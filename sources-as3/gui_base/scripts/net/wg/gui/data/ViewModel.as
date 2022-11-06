package net.wg.gui.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ViewModel extends EventDispatcher implements IDisposable
   {
      
      public static const INT_TYPE:int = 1;
      
      public static const NUMBER_TYPE:int = 2;
      
      public static const BOOL_TYPE:int = 3;
      
      public static const STRING_TYPE:int = 4;
      
      public static const WSTRING_TYPE:int = 5;
      
      public static const VIEW_MODEL_TYPE:int = 6;
       
      
      public var rollbackC:Function = null;
      
      public var getValueC:Function = null;
      
      public var setValueC:Function = null;
      
      public var holdC:Function = null;
      
      public var commitC:Function = null;
      
      public var callbacks:Vector.<Function>;
      
      private var _embedViewModels:Vector.<ViewModel>;
      
      private var _initedEmbedViewModelIdx:int = 0;
      
      protected var isManualControlled:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function ViewModel()
      {
         this._embedViewModels = new Vector.<ViewModel>(0);
         super();
      }
      
      public function commit() : void
      {
         this.commitC();
      }
      
      private function onChangeHanlder(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function dispose() : void
      {
         var _loc1_:ViewModel = null;
         this._disposed = true;
         for each(_loc1_ in this._embedViewModels)
         {
            _loc1_.removeEventListener(Event.CHANGE,this.onChangeHanlder);
         }
         this.callbacks.length = 0;
         this.callbacks = null;
         this._embedViewModels.length = 0;
         this._embedViewModels = null;
         this.rollbackC = null;
         this.getValueC = null;
         this.setValueC = null;
         this.holdC = null;
         this.commitC = null;
      }
      
      public function getEmbedViewModel() : ViewModel
      {
         var _loc1_:ViewModel = null;
         if(this._initedEmbedViewModelIdx < this._embedViewModels.length)
         {
            _loc1_ = this._embedViewModels[this._initedEmbedViewModelIdx];
            if(this._embedViewModels.length <= this._initedEmbedViewModelIdx)
            {
               App.utils.asserter.assert(false,"Not viewModel for idx = " + this._initedEmbedViewModelIdx);
               return null;
            }
            ++this._initedEmbedViewModelIdx;
         }
         return _loc1_;
      }
      
      public function getValue(param1:int, param2:int) : *
      {
         return this.getValueC(param1,param2);
      }
      
      public function hold() : void
      {
         this.holdC();
      }
      
      public function onModelChanged(param1:Array) : void
      {
         var _loc2_:int = 0;
         for each(_loc2_ in param1)
         {
            if(_loc2_ < this.callbacks.length)
            {
               this.callbacks[_loc2_]();
            }
            else
            {
               DebugUtils.LOG_ERROR("onModelChanged. No callback for idx = " + _loc2_);
            }
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function rollback() : void
      {
         this.rollbackC();
      }
      
      public function setValue(param1:int, param2:int, param3:*) : void
      {
         this.setValueC(param1,param2,param3);
      }
      
      protected function registerEmbedViewModel(param1:ViewModel) : void
      {
         param1.isManualControlled = this.isManualControlled;
         this._embedViewModels.push(param1);
         if(this.isManualControlled)
         {
            param1.addEventListener(Event.CHANGE,this.onChangeHanlder);
         }
      }
      
      protected function registerCallbackByIdx(param1:int, param2:Function) : void
      {
         this.callbacks[param1] = param2;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
