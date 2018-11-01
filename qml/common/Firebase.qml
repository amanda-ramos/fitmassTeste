import QtQuick 2.0
import VPlayApps 1.0
import VPlayPlugins 1.0

// Funções de busca e alterações de valor no banco de dados

Item {

    FirebaseDatabase {
        id: databaseFitmass

        config: FirebaseConfig {
            //get these values from the firebase console
            projectId: "fitmass-2018"
            databaseUrl: "https://fitmassapp.firebaseio.com/"

            //platform dependent - get these values from the google-services.json / GoogleService-info.plist
            apiKey: Qt.platform.os === "android" ? "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic" : "AIzaSyBh6Kb12xUnOsQDTP2XEbSKtuGsBfmCyic"
            applicationId: Qt.platform.os === "android" ? "1:519505351771:android:28365556727f1ea3" : "1:519505351771:ios:28365556727f1ea3"
        }
    }

    function dadosUser(){
        databaseFitmass.getValue(keyUser, {
                                 orderByValue: true
                             }, function (success, key, value) {
                                 if (success) {
                                     console.debug(
                                                 "DADOS INICIAS USER - Read value "
                                                 + value + " for key " + key)

                                         qtdeMedida = value3.totalMeasure
                                        graficosConfig();

                                     userGender = value3.gender
                                     var age = value3.birthday

                                     userAge = calculateAge(
                                                 Date.fromLocaleString(
                                                     Qt.locale(), age,
                                                     "dd/MM/yyyy"))

                                     pesoDesejado = value3.desiredWeight

                                     console.log("HISTORICO 1 - idade: " + userAge)
                                     console.log("HISTORICO 1 - qtde de medidas: " + qtdeMedida)

                                     if(qtdeMedida == 0){
                                         novato = true;
                                         console.log("NOVATO")
                                     }else{
                                         novato = false;
                                         filterIcon.visible = true;
                                         console.log("NÃO NOVATO")
                                     }



                                 } else {
                                     console.debug(
                                                 "HISTORICO1 - Error with message: " + value3)
                                     nativeUtils.displayAlertDialog(
                                                 "Error!", value3, "OK")
                                 }
                             })
    }




}
