package net.wg.infrastructure.managers.impl
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import net.wg.infrastructure.interfaces.ISimpleManagedContainer;
   import scaleform.clik.motion.Tween;
   
   public class ContainerManagerLobby extends ContainerManagerBase
   {
      
      private static const NO_LAYER:String = "ContainerManagerLobby does not have container for layer ";
       
      
      private var _tweenByContainer:Dictionary;
      
      public function ContainerManagerLobby()
      {
         this._tweenByContainer = new Dictionary();
         super();
      }
      
      override protected function onDispose() : void
      {
         this.killTweens();
         super.onDispose();
      }
      
      protected function killTweens() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:Tween = null;
         var _loc3_:* = null;
         for(_loc3_ in this._tweenByContainer)
         {
            _loc1_ = DisplayObject(_loc3_);
            _loc2_ = this._tweenByContainer[_loc1_];
            _loc2_.dispose();
            delete this._tweenByContainer[_loc1_];
         }
      }
      
      override protected function showContainers(param1:Vector.<int>, param2:int) : void
      {
         var _loc3_:Tween = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         for each(_loc5_ in param1)
         {
            _loc4_ = _containersMap[_loc5_] as DisplayObject;
            assert(_loc4_ != null,NO_LAYER + _loc5_);
            this.killTweenForContainer(_loc4_);
            _loc4_.visible = true;
            if(param2 > 0)
            {
               _loc4_.cacheAsBitmap = true;
               _loc3_ = new Tween(param2,_loc4_,{"alpha":1},{
                  "onComplete":this.onShowingComplete,
                  "fastTransform":false
               });
               _loc3_.data = {"isHiding":false};
               this._tweenByContainer[_loc4_] = _loc3_;
            }
            else
            {
               _loc4_.alpha = 1;
            }
         }
      }
      
      override protected function hideContainers(param1:Vector.<int>, param2:int) : void
      {
         var _loc3_:Tween = null;
         var _loc4_:DisplayObject = null;
         var _loc5_:int = 0;
         for each(_loc5_ in param1)
         {
            _loc4_ = _containersMap[_loc5_] as DisplayObject;
            assert(_loc4_ != null,NO_LAYER + _loc5_);
            this.killTweenForContainer(_loc4_);
            if(param2 > 0)
            {
               _loc4_.cacheAsBitmap = true;
               _loc3_ = new Tween(param2,_loc4_,{"alpha":0},{
                  "onComplete":this.onHidingComplete,
                  "fastTransform":false
               });
               _loc3_.data = {"isHiding":true};
               this._tweenByContainer[_loc4_] = _loc3_;
            }
            else
            {
               _loc4_.alpha = 0;
               _loc4_.visible = false;
            }
         }
      }
      
      private function killTweenForContainer(param1:DisplayObject) : void
      {
         var _loc2_:Tween = this._tweenByContainer[param1];
         if(_loc2_)
         {
            _loc2_.dispose();
            delete this._tweenByContainer[param1];
         }
      }
      
      private function onHidingComplete(param1:Tween) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         _loc2_.cacheAsBitmap = false;
         _loc2_.visible = false;
         param1.dispose();
         delete this._tweenByContainer[_loc2_];
      }
      
      private function onShowingComplete(param1:Tween) : void
      {
         var _loc2_:DisplayObject = DisplayObject(param1.target);
         _loc2_.cacheAsBitmap = false;
         param1.dispose();
         delete this._tweenByContainer[_loc2_];
      }
      
      override public function as_getVisibleLayers() : Array
      {
         var _loc3_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:Tween = null;
         var _loc1_:Array = super.as_getVisibleLayers();
         var _loc2_:int = _loc1_.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = _loc1_[_loc2_];
            _loc4_ = _containersMap[_loc3_] as DisplayObject;
            if(_loc4_)
            {
               _loc5_ = this._tweenByContainer[_loc4_];
               if(_loc5_ && _loc5_.data.isHiding)
               {
                  _loc1_.splice(_loc2_,1);
               }
            }
            _loc2_--;
         }
         return _loc1_;
      }
      
      override protected function setVisibleLayers(param1:Vector.<int>) : void
      {
         var _loc2_:ISimpleManagedContainer = null;
         super.setVisibleLayers(param1);
         this.killTweens();
         for each(_loc2_ in _containersMap)
         {
            if(_loc2_)
            {
               _loc2_.alpha = !!_loc2_.visible ? Number(1) : Number(0);
            }
         }
      }
   }
}
