package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.filters.BitmapFilter;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.BlurFilter;
   import net.wg.data.constants.generated.LAYER_NAMES;
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.infrastructure.managers.IElementBlurAdapter;
   
   public class ElementBlurAdapter implements IElementBlurAdapter
   {
      
      private static const ANIM_STEP_TIME:int = 20;
      
      private static const BLUR_XY:int = 20;
      
      private static const TOPSUBVIEW_LAYER:int = LAYER_NAMES.LAYER_ORDER.indexOf(LAYER_NAMES.TOP_SUB_VIEW);
      
      private static const VIEW_LAYER:int = LAYER_NAMES.LAYER_ORDER.indexOf(LAYER_NAMES.VIEWS);
       
      
      private var _blurAnimCount:Number = 0;
      
      private var _bluredElements:Vector.<DisplayObject>;
      
      private var _blurAnimRepeatCount:int = 10;
      
      private var _containers:Vector.<DisplayObject> = null;
      
      private var _disposed:Boolean = false;
      
      public function ElementBlurAdapter()
      {
         super();
      }
      
      public function set containers(param1:Vector.<DisplayObject>) : void
      {
         this._containers = param1;
      }
      
      public function blurElements(param1:int, param2:int) : void
      {
         var _loc4_:ISimpleManagedContainer = null;
         var _loc5_:ISimpleManagedContainer = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:IManagedContainer = null;
         var _loc9_:int = 0;
         var _loc10_:uint = 0;
         var _loc11_:IView = null;
         var _loc12_:Array = null;
         var _loc13_:ISimpleManagedContainer = null;
         var _loc14_:DisplayObject = null;
         this.cancelScheduled();
         var _loc3_:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
         for each(_loc5_ in this._containers)
         {
            if(_loc5_.layer < param1)
            {
               if(_loc5_.layer != VIEW_LAYER || param1 > TOPSUBVIEW_LAYER)
               {
                  _loc3_.push(_loc5_);
               }
               else
               {
                  _loc8_ = IManagedContainer(_loc5_);
                  _loc9_ = _loc8_.numChildren;
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc8_.getChildAt(_loc10_) as IView;
                     if(_loc11_)
                     {
                        _loc12_ = _loc11_.getSubContainers();
                        for each(_loc13_ in _loc12_)
                        {
                           if(_loc13_.layer < param1)
                           {
                              _loc3_.push(_loc13_);
                           }
                           else
                           {
                              _loc4_ = _loc13_;
                           }
                        }
                     }
                     _loc10_++;
                  }
               }
            }
            else if(_loc5_.layer == param1)
            {
               _loc4_ = _loc5_;
            }
         }
         _loc6_ = _loc4_.numChildren;
         _loc7_ = 0;
         while(_loc7_ < _loc6_)
         {
            _loc3_.push(_loc4_.getChildAt(_loc7_));
            _loc7_++;
         }
         if(this._bluredElements && this._bluredElements.length)
         {
            for each(_loc14_ in this._bluredElements)
            {
               if(_loc3_.indexOf(_loc14_) == -1)
               {
                  _loc14_.filters = null;
               }
            }
         }
         this._blurAnimCount = 0;
         this._bluredElements = _loc3_;
         this._blurAnimRepeatCount = param2;
         App.utils.scheduler.scheduleRepeatableTask(this.animateBlur,ANIM_STEP_TIME,this._blurAnimRepeatCount,this._bluredElements);
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.cancelScheduled();
         this.cleanUpBluredElements();
         this._containers = null;
      }
      
      public function unblurElements() : void
      {
         this.cancelScheduled();
         if(!this._bluredElements)
         {
            return;
         }
         if(this._blurAnimCount > BLUR_XY || this._blurAnimCount <= 0)
         {
            this._blurAnimCount = BLUR_XY;
         }
         App.utils.scheduler.scheduleRepeatableTask(this.animateUnblur,ANIM_STEP_TIME,this._blurAnimRepeatCount,this._bluredElements);
      }
      
      private function cleanUpBluredElements() : void
      {
         if(this._bluredElements)
         {
            this._bluredElements.splice(0,this._bluredElements.length);
            this._bluredElements = null;
         }
      }
      
      private function animateBlur(param1:Vector.<DisplayObject>) : void
      {
         var _loc3_:BlurFilter = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:BitmapFilter = null;
         this._blurAnimCount += BLUR_XY / this._blurAnimRepeatCount;
         var _loc2_:Number = this._blurAnimCount;
         for each(_loc4_ in param1)
         {
            if(_loc4_)
            {
               if(_loc4_.filters || _loc4_.filters.length)
               {
                  for each(_loc5_ in _loc4_.filters)
                  {
                     _loc3_ = _loc5_ as BlurFilter;
                     if(_loc3_)
                     {
                        _loc2_ = Math.max(_loc3_.blurX,this._blurAnimCount);
                        break;
                     }
                  }
               }
               _loc4_.filters = [new BlurFilter(_loc2_,_loc2_,BitmapFilterQuality.MEDIUM)];
            }
         }
      }
      
      private function animateUnblur(param1:Vector.<DisplayObject>) : void
      {
         var _loc2_:DisplayObject = null;
         this._blurAnimCount -= BLUR_XY / this._blurAnimRepeatCount;
         for each(_loc2_ in param1)
         {
            _loc2_.filters = [new BlurFilter(this._blurAnimCount,this._blurAnimCount,BitmapFilterQuality.LOW)];
         }
         if(this._blurAnimCount <= 0)
         {
            this.cleanUpBluredElements();
         }
      }
      
      private function cancelScheduled() : void
      {
         App.utils.scheduler.cancelTask(this.animateBlur);
         App.utils.scheduler.cancelTask(this.animateUnblur);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
