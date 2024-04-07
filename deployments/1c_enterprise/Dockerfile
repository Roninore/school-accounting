FROM bellsoft/liberica-openjdk-debian:11.0.18-10

RUN apt update && apt upgrade -y

COPY /deployments/1c_enterprise/installer/server64_8_3_23_2040.tar.gz /var/1c/

RUN tar -zxvf /var/1c/server64_8_3_23_2040.tar.gz -C /var/1c/

RUN /var/1c/setup-full-8.3.23.2040-x86_64.run --mode unattended --enable-components server,ws,server_admin,additional_admin_functions

ENV SRV1CV8_KEYTAB=/opt/1cv8/x86_64/8.3.23.2040/usr1cv8.keytab
ENV SRV1CV8_PORT=1540
ENV SRV1CV8_REGPORT=1541
ENV SRV1CV8_RANGE=1560:1591
ENV SRV1CV8_DEBUG=
ENV SRV1CV8_DATA=/home/usr1cv8/.1cv8/1C/1cv8
ENV SRV1CV8_SECLEV=0
ENV SRV1CV8_PINGPERIOD=1000
ENV SRV1CV8_PINGTIMEOUT=5000

EXPOSE 1540
EXPOSE 1541
EXPOSE 1560-1591

CMD ["/opt/1cv8/x86_64/8.3.23.2040/ragent", "-d", "${SRV1CV8_DATA}", "-port", "${SRV1CV8_PORT}", "-regport", "${SRV1CV8_REGPORT}", "-range", "${SRV1CV8_RANGE}", "-seclev", "${SRV1CV8_SECLEV}", "-pingPeriod", "${SRV1CV8_PINGPERIOD}", "-pingTimeout", "${SRV1CV8_PINGTIMEOUT}", "${SRV1CV8_DEBUG}"]
# ОШИБКА В ПАРАМЕТРЕ 4 "${SRV1CV8_PORT}"