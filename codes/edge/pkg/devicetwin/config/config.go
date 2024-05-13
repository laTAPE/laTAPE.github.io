package config

import (
	"sync"

	"github.com/kubeedge/kubeedge/pkg/apis/componentconfig/edgecore/v1alpha2"
)

var config Configure
var once sync.Once

const LOCAL_SOCKET_PATH = "/var/appmessager.sock"

type Configure struct {
	v1alpha2.DeviceTwin
	NodeName string
}

func InitConfigure(deviceTwin *v1alpha2.DeviceTwin, nodeName string) {
	once.Do(func() {
		config = Configure{
			DeviceTwin: *deviceTwin,
			NodeName:   nodeName,
		}
	})
}

func Get() *Configure {
	return &config
}
