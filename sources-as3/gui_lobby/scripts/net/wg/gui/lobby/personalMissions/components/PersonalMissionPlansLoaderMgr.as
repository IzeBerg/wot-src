package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import net.wg.gui.lobby.personalMissions.events.PlanLoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionPlansLoaderMgr extends EventDispatcher implements IDisposable
   {
      
      private static const ERR_LOADING_PLAN_MSG:String = "[PersonalMissionPlansLoaderMgr] didn\'t load swf ";
       
      
      private var _plansLoadedList:Vector.<String> = null;
      
      private var _loaders:Vector.<Loader> = null;
      
      private var _librariesDict:Dictionary;
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionPlansLoaderMgr()
      {
         this._librariesDict = new Dictionary();
         super();
         this._loaders = new Vector.<Loader>(0);
         this._plansLoadedList = new Vector.<String>();
      }
      
      public final function dispose() : void
      {
         var _loc1_:Loader = null;
         this._disposed = true;
         if(this._loaders != null && this._loaders.length > 0)
         {
            for each(_loc1_ in this._loaders)
            {
               this.removeListeners(_loc1_.contentLoaderInfo);
               _loc1_.unloadAndStop(true);
            }
            this._loaders.splice(0,this._loaders.length);
         }
         this._loaders = null;
         App.utils.data.cleanupDynamicObject(this._librariesDict);
         this._librariesDict = null;
         this._plansLoadedList.splice(0,this._plansLoadedList.length);
         this._plansLoadedList = null;
      }
      
      public function loadPlanByName(param1:String) : void
      {
         var _loc2_:URLRequest = null;
         var _loc3_:Loader = null;
         if(this._plansLoadedList.indexOf(param1) >= 0)
         {
            dispatchEvent(new PlanLoaderEvent(PlanLoaderEvent.PLAN_READY,param1));
            return;
         }
         var _loc4_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         _loc2_ = new URLRequest(param1);
         _loc3_ = new Loader();
         this._librariesDict[_loc3_] = param1;
         this._plansLoadedList.push(param1);
         this._loaders.push(_loc3_);
         this.addListeners(_loc3_.contentLoaderInfo);
         _loc3_.load(_loc2_,_loc4_);
      }
      
      private function addListeners(param1:LoaderInfo) : void
      {
         param1.addEventListener(Event.INIT,this.onLoaderInfoInitHandler);
         param1.addEventListener(IOErrorEvent.IO_ERROR,this.onLoaderInfoIoErrorHandler);
      }
      
      private function removeListeners(param1:LoaderInfo) : void
      {
         param1.removeEventListener(Event.INIT,this.onLoaderInfoInitHandler);
         param1.removeEventListener(IOErrorEvent.IO_ERROR,this.onLoaderInfoIoErrorHandler);
      }
      
      private function onLoaderInfoInitHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         var _loc3_:String = this._librariesDict[_loc2_.loader];
         this._plansLoadedList.push(_loc3_);
         dispatchEvent(new PlanLoaderEvent(PlanLoaderEvent.PLAN_READY,_loc3_));
      }
      
      private function onLoaderInfoIoErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         this.removeListeners(_loc2_);
         var _loc3_:String = this._librariesDict[_loc2_.loader];
         DebugUtils.LOG_WARNING(ERR_LOADING_PLAN_MSG + _loc3_);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
