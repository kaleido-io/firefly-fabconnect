// Code generated by mockery v2.29.0. DO NOT EDIT.

package mockws

import mock "github.com/stretchr/testify/mock"

// WebSocketChannels is an autogenerated mock type for the WebSocketChannels type
type WebSocketChannels struct {
	mock.Mock
}

// GetChannels provides a mock function with given fields: topic
func (_m *WebSocketChannels) GetChannels(topic string) (chan<- interface{}, chan<- interface{}, <-chan error, <-chan struct{}) {
	ret := _m.Called(topic)

	var r0 chan<- interface{}
	var r1 chan<- interface{}
	var r2 <-chan error
	var r3 <-chan struct{}
	if rf, ok := ret.Get(0).(func(string) (chan<- interface{}, chan<- interface{}, <-chan error, <-chan struct{})); ok {
		return rf(topic)
	}
	if rf, ok := ret.Get(0).(func(string) chan<- interface{}); ok {
		r0 = rf(topic)
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(chan<- interface{})
		}
	}

	if rf, ok := ret.Get(1).(func(string) chan<- interface{}); ok {
		r1 = rf(topic)
	} else {
		if ret.Get(1) != nil {
			r1 = ret.Get(1).(chan<- interface{})
		}
	}

	if rf, ok := ret.Get(2).(func(string) <-chan error); ok {
		r2 = rf(topic)
	} else {
		if ret.Get(2) != nil {
			r2 = ret.Get(2).(<-chan error)
		}
	}

	if rf, ok := ret.Get(3).(func(string) <-chan struct{}); ok {
		r3 = rf(topic)
	} else {
		if ret.Get(3) != nil {
			r3 = ret.Get(3).(<-chan struct{})
		}
	}

	return r0, r1, r2, r3
}

// SendReply provides a mock function with given fields: message
func (_m *WebSocketChannels) SendReply(message interface{}) {
	_m.Called(message)
}

type mockConstructorTestingTNewWebSocketChannels interface {
	mock.TestingT
	Cleanup(func())
}

// NewWebSocketChannels creates a new instance of WebSocketChannels. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
func NewWebSocketChannels(t mockConstructorTestingTNewWebSocketChannels) *WebSocketChannels {
	mock := &WebSocketChannels{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}
