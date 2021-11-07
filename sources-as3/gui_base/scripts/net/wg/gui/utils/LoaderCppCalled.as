package net.wg.gui.utils
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class LoaderCppCalled
   {
      
      private static var _instance:LoaderCppCalled;
       
      
      private var _callbackMap:Dictionary;
      
      private var _loaderMap:Dictionary;
      
      public function LoaderCppCalled()
      {
         this._callbackMap = new Dictionary();
         this._loaderMap = new Dictionary();
         super();
      }
      
      public static function get instance() : LoaderCppCalled
      {
         if(!_instance)
         {
            _instance = new LoaderCppCalled();
         }
         return _instance;
      }
      
      public function cancelLoadView(param1:String) : void
      {
         var _loc3_:Loader = null;
         var _loc4_:Loader = null;
         if(!this._callbackMap[param1])
         {
            DebugUtils.LOG_WARNING("No callback for id = " + param1);
         }
         delete this._callbackMap[param1];
         var _loc2_:Boolean = false;
         for each(_loc4_ in this._loaderMap)
         {
            if(this._loaderMap[_loc4_] == param1)
            {
               _loc3_.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onViewLoadCompleteHandler);
               _loc3_.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onViewLoadErrorHandler);
               delete this._loaderMap[_loc4_];
               _loc2_ = true;
               break;
            }
         }
         if(_loc2_)
         {
            DebugUtils.LOG_WARNING("No loader for id = " + param1);
         }
      }
      
      public function loadView(param1:String, param2:int, param3:Function) : void
      {
         var _loc6_:LoaderContext = null;
         var _loc4_:Loader = new Loader();
         var _loc5_:LoaderInfo = _loc4_.contentLoaderInfo;
         _loc5_.addEventListener(Event.COMPLETE,this.onViewLoadCompleteHandler,false,0,true);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onViewLoadErrorHandler,false,0,true);
         if(!this._callbackMap[_loc4_])
         {
            this._callbackMap[param2] = param3;
            this._loaderMap[_loc4_] = param2;
            _loc6_ = new LoaderContext(false,ApplicationDomain.currentDomain);
            _loc4_.load(new URLRequest(param1),_loc6_);
         }
         else
         {
            DebugUtils.LOG_DEBUG("contentID = " + param2 + " already registered.");
         }
      }
      
      private function removeDependencies(param1:Loader) : void
      {
         param1.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onViewLoadCompleteHandler);
         param1.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onViewLoadErrorHandler);
         var _loc2_:String = this._loaderMap[param1];
         delete this._loaderMap[param1];
         delete this._callbackMap[_loc2_];
      }
      
      private function onViewLoadCompleteHandler(param1:Event) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         var _loc3_:Loader = _loc2_.loader;
         var _loc4_:String = this._loaderMap[_loc3_];
         var _loc5_:Function = this._callbackMap[_loc4_];
         _loc5_(true,_loc3_.content);
         this.removeDependencies(_loc3_);
      }
      
      private function onViewLoadErrorHandler(param1:IOErrorEvent) : void
      {
         var _loc2_:LoaderInfo = LoaderInfo(param1.currentTarget);
         var _loc3_:Loader = _loc2_.loader;
         var _loc4_:String = this._loaderMap[_loc3_];
         var _loc5_:Function = this._callbackMap[_loc4_];
         _loc5_(false,param1.text);
         this.removeDependencies(_loc3_);
         DebugUtils.LOG_ERROR(param1.text);
      }
   }
}
