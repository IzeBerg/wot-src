from constants import IS_DEVELOPMENT
if IS_DEVELOPMENT:
    import VSE
    from plan_holder import PlanHolder
    import weakref
    from debug_utils import LOG_DEBUG_DEV
    from plan_tags import getAllTags

    class DebugPlanHolder(PlanHolder):
        __slots__ = 'contextName'

        def __init__(self, plan, state, auto=False):
            super(DebugPlanHolder, self).__init__(plan, state, auto)
            self.contextName = ''


    class DebugPlanLoader(object):

        def __init__(self):
            self.__contextAll = []
            self.__plans = {}
            self.__tags = getAllTags()

        def getContext(self, name):
            for ctx in self.__contextAll:
                if type(ctx()).__name__ == name:
                    return ctx()

            return

        def regContext(self, context):
            for ctx in self.__contextAll:
                if ctx() == context:
                    break
            else:
                self.__contextAll.append(weakref.ref(context))
                LOG_DEBUG_DEV('VSContext %s was registered' % type(context).__name__)

        def unregContext(self, context):
            for ctx in self.__contextAll[:]:
                if ctx() == context:
                    self.__contextDestroyed(context)
                    self.__contextAll.remove(ctx)
                    LOG_DEBUG_DEV('VSContext %s was unregistered' % type(context).__name__)
                    break

        def startPlan(self, planName, contextName, aspect, params={}):
            if planName in self.__plans:
                self.__plans[planName].start()
                return True
            holder = DebugPlanHolder(VSE.Plan(), PlanHolder.LOADING, False)
            holder.params = params
            if contextName != '':
                context = self.getContext(contextName)
                if context:
                    holder.plan.setContext(context)
                    holder.contextName = contextName
                else:
                    return False
            holder.load(planName, aspect, self.__tags)
            if holder.isLoaded:
                holder.start()
                self.__plans[planName] = holder
                return True
            return False

        def stopPlan(self, planName):
            if planName in self.__plans:
                self.__plans[planName].plan.stop()
                del self.__plans[planName]
                return True
            return False

        def stopAllPlans(self):
            res = True
            for planName in list(self.__plans.keys()):
                res &= self.stopPlan(planName)

            return res

        def __contextDestroyed(self, context):
            for planName in list(self.__plans.keys()):
                holder = self.__plans[planName]
                if holder.contextName == type(context).__name__:
                    holder.plan.stop()
                    del self.__plans[planName]


    debugPlanLoader = DebugPlanLoader()