package net.wg.gui.lobby.tank_setup
{
   import fl.transitions.easing.Regular;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.lobby.hangar.HangarAmunitionSwitchAnimator;
   import net.wg.gui.lobby.hangar.interfaces.IVehicleParameters;
   import net.wg.infrastructure.base.meta.IAmmunitionSetupViewMeta;
   import net.wg.infrastructure.base.meta.impl.AmmunitionSetupViewMeta;
   import net.wg.infrastructure.interfaces.IDAAPIModule;
   import scaleform.clik.motion.Tween;
   
   public class AmmunitionSetupView extends AmmunitionSetupViewMeta implements IAmmunitionSetupViewMeta
   {
      
      private static const PARAMS_MARGIN_TOP:int = 141;
      
      private static const PARAMS_MARGIN_BOTTOM:int = 178;
      
      private static const BOTTOM_PANEL_HEIGHT:int = 35;
      
      private static const MAX_PARAMS_OFFSET:int = 66;
      
      private static const PARAMS_ANIM_OFFSET_Y:int = 70;
      
      private static const ANIM_DURATION:int = 300;
      
      private static const GF_H_MARGIN:int = 10;
       
      
      public var gfContent:AmmunitionSetupViewInject = null;
      
      public var params:IVehicleParameters;
      
      private var _viewTween:Tween;
      
      private var _paramsTween:Tween;
      
      private var _paramsPositionInited:Boolean = false;
      
      private var _appStage:Stage;
      
      public function AmmunitionSetupView()
      {
         this._appStage = App.stage;
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         _originalWidth = param1;
         _originalHeight = param2;
         if(this.gfContent)
         {
            this.gfContent.setSize(param1 + GF_H_MARGIN * 2,param2 + BOTTOM_PANEL_HEIGHT);
         }
         this.updateParamsVertLayout();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.params.alpha = 0;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         if(this.gfContent != null)
         {
            registerFlashComponentS(IDAAPIModule(this.gfContent),HANGAR_ALIASES.AMMUNITION_SETUP_VIEW_INJECT);
            this.gfContent.x = -GF_H_MARGIN;
            this.gfContent.y = 0;
         }
         this.params.showShadowLipWhenOverflow = true;
         this.params.snapHeightToRenderers = false;
         this.params.hideBg();
         this.params.forceInvalidateOnDataChange = true;
         this.updateParamsVertLayout();
         registerFlashComponentS(this.params,HANGAR_ALIASES.AMMUNITION_SETUP_VIEW_VEHICLE_PARAMS);
         setFocus(this.gfContent);
         if(App.gameInputMgr)
         {
            App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown,true);
         }
      }
      
      override protected function onDispose() : void
      {
         if(App.gameInputMgr)
         {
            App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyDown);
         }
         this.gfContent = null;
         this.params = null;
         this._appStage = null;
         if(this._viewTween)
         {
            this._viewTween.dispose();
            this._viewTween = null;
         }
         if(this._paramsTween)
         {
            this._paramsTween.dispose();
            this._paramsTween = null;
         }
         super.onDispose();
      }
      
      public function as_gfSizeUpdated(param1:int, param2:int) : void
      {
         var _loc3_:int = App.appWidth - param2 - param1;
         var _loc4_:int = _loc3_ - this.params.width >> 1;
         if(_loc4_ > MAX_PARAMS_OFFSET)
         {
            _loc4_ = MAX_PARAMS_OFFSET;
         }
         this.params.x = param2 + param1 + _loc4_;
         if(!this._paramsPositionInited)
         {
            this._paramsPositionInited = true;
            this.showView();
         }
      }
      
      public function as_onAnimationEnd() : void
      {
         mouseChildren = true;
         mouseEnabled = true;
      }
      
      public function as_showCloseAnim() : void
      {
         if(this._paramsTween)
         {
            this._paramsTween.dispose();
         }
         this._paramsTween = new Tween(ANIM_DURATION,this.params,{
            "alpha":0,
            "y":this.params.y + PARAMS_ANIM_OFFSET_Y
         },{
            "ease":Regular.easeIn,
            "fastTransform":false,
            "onComplete":this.onHideAnimComplete
         });
         this._appStage.dispatchEvent(new Event(HangarAmunitionSwitchAnimator.MAKE_HANGAR_VISIBILE));
      }
      
      private function updateParamsVertLayout() : void
      {
         this.params.y = PARAMS_MARGIN_TOP;
         this.params.height = _originalHeight - this.params.y - PARAMS_MARGIN_BOTTOM ^ 0;
         invalidateSize();
      }
      
      private function showView() : void
      {
         this._viewTween = new Tween(ANIM_DURATION,this.params,{"alpha":1},{
            "fastTransform":false,
            "ease":Regular.easeOut
         });
         this._paramsTween = new Tween(ANIM_DURATION,this.params,{"y":this.params.y},{
            "fastTransform":false,
            "ease":Regular.easeOut,
            "onComplete":this.onShowComplete
         });
         this.params.y += PARAMS_ANIM_OFFSET_Y;
         this._appStage.dispatchEvent(new Event(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_START));
      }
      
      private function onHideAnimComplete() : void
      {
         this._appStage.dispatchEvent(new Event(HangarAmunitionSwitchAnimator.PLAY_ANIM_SHOW_HANGAR));
         onCloseS();
      }
      
      private function onShowComplete() : void
      {
         this._appStage.dispatchEvent(new Event(HangarAmunitionSwitchAnimator.AMMUNITION_VIEW_SHOW_ANIM_COMPLETE));
         this._viewTween.dispose();
         this._paramsTween.dispose();
      }
      
      private function onEscapeKeyDown() : void
      {
         onEscapePressS();
      }
   }
}
