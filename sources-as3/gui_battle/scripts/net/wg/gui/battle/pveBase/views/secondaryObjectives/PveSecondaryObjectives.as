package net.wg.gui.battle.pveBase.views.secondaryObjectives
{
   import fl.transitions.easing.Regular;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.components.PveObjectAnim;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.data.PveObjectVO;
   import net.wg.gui.battle.pveBase.views.secondaryObjectives.events.PveSecondaryObjectivesEvent;
   import net.wg.infrastructure.base.meta.IPveSecondaryObjectivesMeta;
   import net.wg.infrastructure.base.meta.impl.PveSecondaryObjectivesMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.motion.Tween;
   
   public class PveSecondaryObjectives extends PveSecondaryObjectivesMeta implements IPveSecondaryObjectivesMeta
   {
      
      private static const LINKAGE_PVE_OBJECT_ANIM:String = "PveObjectAnimUI";
      
      private static const OBJECT_RENDERER_HEIGHT:int = 74;
      
      private static const LAST_HIDE_GREEN_FRAME:int = 234;
      
      private static const LAST_HIDE_RED_FRAME:int = 358;
      
      private static const LAST_HIDE_FRAME:int = 452;
      
      private static const ANIMATION_DURATION:int = 750;
       
      
      private var _objects:Vector.<PveObjectAnim>;
      
      private var _forRemoveObjects:Vector.<PveObjectAnim>;
      
      private var _tweens:Vector.<Tween>;
      
      public function PveSecondaryObjectives()
      {
         this._objects = new Vector.<PveObjectAnim>();
         this._forRemoveObjects = new Vector.<PveObjectAnim>();
         this._tweens = new Vector.<Tween>(0);
         super();
      }
      
      private function setPosition() : void
      {
         var _loc1_:int = this._objects.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            if(this._objects[_loc3_].y < _loc2_)
            {
               this._tweens.push(new Tween(ANIMATION_DURATION,this._objects[_loc3_],{"y":_loc2_},{
                  "ease":Regular.easeInOut,
                  "fastTransform":false
               }));
            }
            else
            {
               this._objects[_loc3_].y = _loc2_;
            }
            _loc2_ -= OBJECT_RENDERER_HEIGHT + 1;
            _loc3_++;
         }
      }
      
      private function pushObject(param1:PveObjectAnim) : void
      {
         this._objects.push(param1);
         addChild(param1);
         this.setPosition();
         dispatchEvent(new PveSecondaryObjectivesEvent(PveSecondaryObjectivesEvent.CHANGED));
      }
      
      private function getObject(param1:String) : PveObjectAnim
      {
         var _loc2_:int = this._objects.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(this._objects[_loc3_].id == param1)
            {
               return this._objects[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      private function onHidePlayComplete() : void
      {
         var _loc1_:PveObjectAnim = this._forRemoveObjects.shift();
         if(_loc1_)
         {
            removeChild(_loc1_);
            _loc1_.addFrameScript(LAST_HIDE_GREEN_FRAME,null);
            _loc1_.addFrameScript(LAST_HIDE_RED_FRAME,null);
            _loc1_.addFrameScript(LAST_HIDE_FRAME,null);
            this._objects.splice(this._objects.indexOf(_loc1_,0),1);
            dispatchEvent(new PveSecondaryObjectivesEvent(PveSecondaryObjectivesEvent.CHANGED));
         }
         this.setPosition();
      }
      
      private function disposeObjects(param1:Boolean = true) : void
      {
         var _loc2_:PveObjectAnim = null;
         var _loc3_:int = this._objects.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = this._objects[_loc4_];
            removeChild(_loc2_);
            _loc2_.addFrameScript(LAST_HIDE_GREEN_FRAME,null);
            _loc2_.addFrameScript(LAST_HIDE_RED_FRAME,null);
            _loc2_.addFrameScript(LAST_HIDE_FRAME,null);
            _loc2_.dispose();
            _loc4_++;
         }
         this._objects.splice(0,this._objects.length);
         if(param1)
         {
            this._objects = null;
         }
      }
      
      private function disposeForRemoveObjects(param1:Boolean = true) : void
      {
         this._forRemoveObjects.splice(0,this._forRemoveObjects.length);
         if(param1)
         {
            this._forRemoveObjects = null;
         }
      }
      
      private function disposeTweens(param1:Boolean = true) : void
      {
         var _loc2_:Tween = null;
         for each(_loc2_ in this._tweens)
         {
            _loc2_.dispose();
         }
         this._tweens.length = 0;
         if(param1)
         {
            this._tweens = null;
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeObjects();
         this.disposeForRemoveObjects();
         this.disposeTweens();
         super.onDispose();
      }
      
      override protected function addObject(param1:PveObjectVO) : void
      {
         var _loc2_:IClassFactory = App.utils.classFactory;
         var _loc3_:Class = _loc2_.getClass(LINKAGE_PVE_OBJECT_ANIM);
         var _loc4_:PveObjectAnim = new _loc3_();
         _loc4_.setData(param1);
         this.pushObject(_loc4_);
      }
      
      public function as_removeObject(param1:String, param2:String) : void
      {
         var _loc3_:PveObjectAnim = this.getObject(param1);
         if(_loc3_)
         {
            _loc3_.addFrameScript(LAST_HIDE_GREEN_FRAME,this.onHidePlayComplete);
            _loc3_.addFrameScript(LAST_HIDE_RED_FRAME,this.onHidePlayComplete);
            _loc3_.addFrameScript(LAST_HIDE_FRAME,this.onHidePlayComplete);
            _loc3_.hide(param2);
            this._forRemoveObjects.push(_loc3_);
         }
      }
      
      public function as_setProgressBarValue(param1:String, param2:int) : void
      {
         var _loc3_:PveObjectAnim = this.getObject(param1);
         if(_loc3_)
         {
            _loc3_.setProgressBarValue(param2);
         }
      }
      
      public function as_updateTime(param1:String, param2:String, param3:Boolean) : void
      {
         var _loc4_:PveObjectAnim = this.getObject(param1);
         if(_loc4_)
         {
            _loc4_.updateTime(param2,param3);
         }
      }
      
      public function as_setAlarm(param1:String, param2:Boolean) : void
      {
         var _loc3_:PveObjectAnim = this.getObject(param1);
         if(_loc3_)
         {
            _loc3_.setAlarm(param2);
         }
      }
      
      public function as_setTitle(param1:String, param2:String) : void
      {
         var _loc3_:PveObjectAnim = this.getObject(param1);
         if(_loc3_)
         {
            _loc3_.setTitle(param2);
         }
      }
      
      public function hasObjects() : Boolean
      {
         return this._objects.length > 0;
      }
      
      public function as_clear() : void
      {
         if(this._objects.length > 0)
         {
            this.disposeObjects(false);
            this.disposeForRemoveObjects(false);
            this.disposeTweens(false);
            dispatchEvent(new PveSecondaryObjectivesEvent(PveSecondaryObjectivesEvent.CHANGED));
         }
      }
   }
}
