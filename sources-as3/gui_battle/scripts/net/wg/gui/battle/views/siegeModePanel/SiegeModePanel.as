package net.wg.gui.battle.views.siegeModePanel
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.SIEGE_MODE_CONSTS;
   import net.wg.infrastructure.base.meta.ISiegeModeIndicatorMeta;
   import net.wg.infrastructure.base.meta.impl.SiegeModeIndicatorMeta;
   
   public class SiegeModePanel extends SiegeModeIndicatorMeta implements ISiegeModeIndicatorMeta
   {
       
      
      public var animationContainer:MovieClip = null;
      
      private var _siegeModeType:String = "";
      
      private var _currentAnimation:SiegeModeAnimation = null;
      
      public function SiegeModePanel()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._currentAnimation)
         {
            this.animationContainer.removeChild(this._currentAnimation);
            this._currentAnimation.dispose();
            this._currentAnimation = null;
         }
         this.animationContainer = null;
         super.onDispose();
      }
      
      public function as_setAutoSiegeModeState(param1:int, param2:String) : void
      {
         this._currentAnimation.setAutoSiegeModeState(param1,param2);
      }
      
      public function as_setSiegeModeType(param1:String) : void
      {
         var _loc2_:String = null;
         var _loc3_:Class = null;
         App.utils.asserter.assert(SIEGE_MODE_CONSTS.SIEGE_MODE_TYPES.indexOf(param1) >= 0,"Unknown siege mode type: " + param1);
         if(this._siegeModeType == param1)
         {
            return;
         }
         this._siegeModeType = param1;
         if(this._currentAnimation)
         {
            this.animationContainer.removeChild(this._currentAnimation);
            this._currentAnimation.dispose();
         }
         switch(this._siegeModeType)
         {
            case SIEGE_MODE_CONSTS.TURBOSHAFT_ENGINE_TYPE:
               _loc2_ = Linkages.TURBO_SIEGE_MODE_ANIMATION_UI;
               _loc3_ = TurboSiegeModeAnimation;
               break;
            case SIEGE_MODE_CONSTS.TRACK_WITHIN_TRACK_TYPE:
               _loc2_ = Linkages.YOH_CHASSIS_MODE_ANIMATION_UI;
               _loc3_ = YohChassisModeAnimation;
               break;
            case SIEGE_MODE_CONSTS.TWIN_GUN_TYPE:
               _loc2_ = Linkages.TWIN_GUN_MODE_ANIMATION_UI;
               _loc3_ = TwinGunModeAnimation;
               break;
            default:
               _loc2_ = Linkages.SIEGE_MODE_ANIMATION_UI;
               _loc3_ = SiegeModeAnimation;
         }
         this._currentAnimation = App.utils.classFactory.getComponent(_loc2_,_loc3_);
         this.animationContainer.addChild(this._currentAnimation);
      }
      
      public function as_setVisible(param1:Boolean) : void
      {
         _isCompVisible = param1;
         this.visible = this.animationContainer.visible = param1;
      }
      
      public function as_switchSiegeState(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void
      {
         this._currentAnimation.switchSiegeState(param1,param2,param3,param4,param5);
      }
      
      public function as_switchSiegeStateSnapshot(param1:Number, param2:Number, param3:int, param4:String, param5:Boolean) : void
      {
         this._currentAnimation.switchSiegeStateSnapshot(param1,param2,param3,param4,param5);
      }
      
      public function as_updateDeviceState(param1:String, param2:String) : void
      {
         this._currentAnimation.updateDeviceState(param1,param2);
      }
      
      public function as_updateLayout(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
   }
}
