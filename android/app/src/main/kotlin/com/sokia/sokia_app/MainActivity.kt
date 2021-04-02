package com.sokia.sokia_app

import android.content.ComponentName
import android.content.Intent
import android.content.ServiceConnection
import android.net.Uri
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.util.Log
import android.widget.Switch
import android.widget.Toast
import com.oppwa.mobile.connect.checkout.dialog.CheckoutActivity
import com.oppwa.mobile.connect.checkout.meta.CheckoutSettings
import com.oppwa.mobile.connect.exception.PaymentError
import com.oppwa.mobile.connect.exception.PaymentException
import com.oppwa.mobile.connect.payment.BrandsValidation
import com.oppwa.mobile.connect.payment.CheckoutInfo
import com.oppwa.mobile.connect.payment.ImagesRequest
import com.oppwa.mobile.connect.provider.*
import com.oppwa.mobile.connect.service.ConnectService
import com.oppwa.mobile.connect.service.IProviderBinder
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlesignin.GoogleSignInPlugin
import java.util.*


class MainActivity : FlutterActivity(), ITransactionListener, MethodChannel.Result {

    private companion object {
        const val CHANNEL = "com.sokia.app";
    }

    private var checkoutId = ""
    private var developmentMode = ""
    private var binder: IProviderBinder? = null
    private var result: MethodChannel.Result? = null
    private var brand = ""
    private var language = ""
    private val handler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
                .setMethodCallHandler { call, result ->


                    if (call.method.equals("getPaymentMethod")) {
                        this.result = result
                        checkoutId = call.argument<String>("checkoutId")!!
                        developmentMode = call.argument<String>("developmentMode")!!
                        brand = call.argument<String>("brand")!!
                        language = call.argument<String>("language")!!
                        openCheckoutUI(checkoutId, brand)
                    } else {
                        error("1", "Method name is not found", "")
                    }
                }
    }

    private fun openCheckoutUI(checkoutId: String, brand: String) {
        val paymentBrands: MutableSet<String> = LinkedHashSet()
        if (brand == "MADA") {
            paymentBrands.add("MADA")
        } else {
            paymentBrands.add("VISA")
            paymentBrands.add("MASTER")
            paymentBrands.add("PAYPAL")
            paymentBrands.add("SADAD")
            paymentBrands.add("STC_PAY")
        }

        var checkoutSettings = CheckoutSettings(checkoutId, paymentBrands,
                Connect.ProviderMode.TEST)
        if (developmentMode == "LIVE") {
            checkoutSettings = CheckoutSettings(checkoutId, paymentBrands,
                    Connect.ProviderMode.LIVE)
        }

        checkoutSettings.shopperResultUrl = "com.sokia.app://result"
        checkoutSettings.isTotalAmountRequired = true

        if (language == "ar")
            checkoutSettings.locale = "ar_AR"
        else
            checkoutSettings.locale = "en_US"

        val componentName = ComponentName(
                packageName, CheckoutBroadcastReceiver::class.java.name)


        /* Set up the Intent and start the checkout activity. */
        val intent = checkoutSettings.createCheckoutActivityIntent(this, componentName)
        startActivityForResult(intent, CheckoutActivity.REQUEST_CODE_CHECKOUT)
    }

    private val serviceConnection: ServiceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName, service: IBinder) {
            binder = service as IProviderBinder
            if (binder != null) {
                binder!!.addTransactionListener(this@MainActivity)

                /* we have a connection to the service */
                try {
                    if (developmentMode == "LIVE") {
                        binder!!.initializeProvider(Connect.ProviderMode.LIVE)
                    } else {
                        binder!!.initializeProvider(Connect.ProviderMode.TEST)
                    }
                } catch (ee: PaymentException) {
                }
            } else {
                print("binder null");
            }
        }

        override fun onServiceDisconnected(name: ComponentName) {
            binder = null
        }
    }

    override fun onStart() {
        super.onStart()
        val intent = Intent(this, ConnectService::class.java)
        startService(intent)
        bindService(intent, serviceConnection, BIND_AUTO_CREATE)
    }

    override fun onDestroy() {
        super.onDestroy()
        unbindService(serviceConnection)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        when (requestCode) {
            CheckoutActivity.REQUEST_CODE_CHECKOUT -> {
                when (resultCode) {
                    CheckoutActivity.RESULT_OK -> {
                        /* transaction completed */
                        val transaction: Transaction = data!!.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_TRANSACTION)!!

                        /* resource path if needed */
                        val resourcePath = data.getStringExtra(CheckoutActivity.CHECKOUT_RESULT_RESOURCE_PATH)
                        Log.e("resourcePath", "ResourcePath -----> $resourcePath")

                        if (transaction.transactionType == TransactionType.SYNC) {
                            /* check the result of synchronous transaction */
                            success("true")
                        }
                    }
                    CheckoutActivity.RESULT_CANCELED -> {
                        error("2", "canceled", "User Cancelled Payment")
                    }
                    CheckoutActivity.RESULT_ERROR -> {

                        /* error occurred */
                        val error: PaymentError = data!!.getParcelableExtra(CheckoutActivity.CHECKOUT_RESULT_ERROR)!!

                        Log.e("error1", error.errorInfo.toString())

                        Log.e("error2", error.errorCode.toString())

                        Log.e("error3", error.errorMessage)

                        Log.e("error4", error.describeContents().toString())

                        error("3", "false ${error.errorMessage}", "")

                    }
                }
            }
            else -> {

            }
        }

    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        if (intent.scheme == "com.sokia.app") {
            success("true")
        }
    }


    override fun brandsValidationRequestSucceeded(p0: BrandsValidation?) {
    }

    override fun brandsValidationRequestFailed(p0: PaymentError?) {
    }

    override fun imagesRequestSucceeded(p0: ImagesRequest?) {
    }

    override fun imagesRequestFailed() {
    }

    override fun paymentConfigRequestSucceeded(p0: CheckoutInfo?) {
    }

    override fun paymentConfigRequestFailed(p0: PaymentError?) {
    }

    override fun transactionCompleted(transaction: Transaction?) {
        if (transaction == null) {
            return
        }

        if (transaction.transactionType == TransactionType.SYNC) {
            success("true")
        } else {
            /* wait for the callback in the s */
            val uri = Uri.parse(transaction.redirectUrl)
            val intent = Intent(Intent.ACTION_VIEW, uri)
            startActivity(intent)
        }
    }

    override fun transactionFailed(transaction: Transaction?, p1: PaymentError?) {
        error("1", "false", "")
    }


    private var firedSuccess: Boolean = false
    override fun success(obj: Any?) {
        if (!firedSuccess) {
            handler.post {
                firedSuccess = true
                result!!.success(obj)
            }
        }
    }

    private var firedError: Boolean = false

    override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
        if (!firedError) handler.post {
            firedError = true
            result!!.error(errorCode, errorMessage, errorDetails)
        }
    }

    private var firedNotImplemented: Boolean = false

    override fun notImplemented() {
        if (!firedNotImplemented) handler.post {
            firedNotImplemented = true
            result!!.notImplemented()
        }
    }
}
