from enum import Enum, unique
MAX_CHANNEL_HISTORY = 10
CHANNEL_UNSUBSCRIPTION_DELAY = 60

@unique
class SubscriptionCommand(Enum):
    Subscribe = 'subscribe'
    Unsubscribe = 'unsubscribe'
    GetLast = 'get_last'


@unique
class SubscriptionServerStatus(Enum):
    Subscribed = 'subscribed'
    NotExists = 'not_exists'
    ChannelsLimit = 'channels_limit'
    Unsubscribed = 'unsubscribed'
    NotSubscribed = 'not_subscribed'
    ChannelDeleted = 'channel_deleted'
    UnknownCommand = 'unknown_command'
    NameNotAllowed = 'name_not_allowed'
    CachedMessage = 'cached_message'
    NoCachedMessage = 'no_cached_message'

    @classmethod
    def fromString(cls, value):
        if value in [ item.value for item in cls ]:
            return cls(value)
        return cls.UnknownCommand


@unique
class SubscriptionClientStatus(Enum):
    NotExists = 'not_exists'
    Unsubscribed = 'unsubscribed'
    Subscribing = 'subscribing'
    Subscribed = 'subscribed'
    Unsubscribing = 'unsubscribing'
    Disabled = 'disabled'
    InvalidObject = 'invalid_object'
    NameNotAllowed = 'name_not_allowed'
    AlreadySubscribed = 'already_subscribed'


@unique
class SubscriptionCloseReason(Enum):
    Request = 'request'
    Cancel = 'cancel'
    Deleted = 'deleted'