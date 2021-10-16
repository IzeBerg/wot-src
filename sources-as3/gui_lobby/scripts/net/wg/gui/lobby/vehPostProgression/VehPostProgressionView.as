package net.wg.gui.lobby.vehPostProgression
{
   import net.wg.data.constants.generated.HANGAR_ALIASES;
   import net.wg.gui.components.advanced.BackButton;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.infrastructure.base.meta.IVehiclePostProgressionViewMeta;
   import net.wg.infrastructure.base.meta.impl.VehiclePostProgressionViewMeta;
   import net.wg.infrastructure.uilogger.veh_post_progression.LogModificationTree;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehPostProgressionView extends VehiclePostProgressionViewMeta implements IVehiclePostProgressionViewMeta
   {
      
      private static const COOLDOWN:int = 250;
      
      private static const BTN_ABOUT_RIGHT_MARGIN:int = 30;
       
      
      public var aboutButton:SoundButtonEx = null;
      
      public var backButton:BackButton = null;
      
      protected var _loggerModifications:LogModificationTree;
      
      private var _requestInCoolDown:Boolean = false;
      
      private var _wasSmallSizeAtEnter:Boolean = false;
      
      private var _isFirstLayoutUpdate:Boolean = true;
      
      public function VehPostProgressionView()
      {
         this._loggerModifications = new LogModificationTree();
         super();
         addChild(this.backButton);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(_vo && isInvalid(InvalidationType.DATA))
         {
            this.backButton.label = _vo.backBtnLabel;
            this.backButton.descrLabel = _vo.backBtnDescrLabel;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.aboutButton.x = width - this.aboutButton.hitMc.width - BTN_ABOUT_RIGHT_MARGIN >> 0;
            if(width >= SizeSettings.extraSmall.breakPointX)
            {
               if(this._wasSmallSizeAtEnter)
               {
                  this._loggerModifications.logResize();
               }
            }
            else if(this._isFirstLayoutUpdate)
            {
               this._wasSmallSizeAtEnter = true;
               this._isFirstLayoutUpdate = false;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         App.utils.scheduler.cancelTask(this.deactivateCoolDown);
         this.backButton.removeEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.aboutButton.removeEventListener(ButtonEvent.CLICK,this.onAboutButtonClickHandler);
         _vehicleBlock.removeEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW,this.onRendererGoToVehicleViewHandler);
         _vehicleBlock.removeEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE,this.onRendererClickVehicleCompareHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.deactivateCoolDown();
         this._loggerModifications.dispose();
         this._loggerModifications = null;
         this.backButton.dispose();
         this.backButton = null;
         this.aboutButton.dispose();
         this.aboutButton = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.aboutButton.addEventListener(ButtonEvent.CLICK,this.onAboutButtonClickHandler);
         this.backButton.addEventListener(ButtonEvent.CLICK,this.onBackBtnClickHandler);
         this.aboutButton.label = VEH_POST_PROGRESSION.VEHPOSTPROGRESSIONVIEW_ABOUT;
         this.aboutButton.validateNow();
         vehParamsPanel.panel.showBottomShadowLipAlways = true;
         _vehicleBlock.addEventListener(TechTreeEvent.GO_TO_VEHICLE_VIEW,this.onRendererGoToVehicleViewHandler,false,0,true);
         _vehicleBlock.addEventListener(TechTreeEvent.CLICK_VEHICLE_COMPARE,this.onRendererClickVehicleCompareHandler,false,0,true);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._loggerModifications.enterScreen();
         registerFlashComponentS(injectComponent,HANGAR_ALIASES.POST_PROGRESSION_INJECT);
      }
      
      override protected function onEscapeClickHandler() : void
      {
         this._loggerModifications.exitScreenWithEscButton();
         onGoBackClickS();
      }
      
      private function activateCoolDown() : void
      {
         this._requestInCoolDown = true;
         App.utils.scheduler.scheduleTask(this.deactivateCoolDown,COOLDOWN);
      }
      
      private function deactivateCoolDown() : void
      {
         this._requestInCoolDown = false;
      }
      
      private function onBackBtnClickHandler(param1:ButtonEvent) : void
      {
         this._loggerModifications.exitScreenWithBackButton();
         onGoBackClickS();
      }
      
      private function onAboutButtonClickHandler(param1:ButtonEvent) : void
      {
         onAboutClickS();
      }
      
      private function onRendererGoToVehicleViewHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && param1.index > -1)
         {
            this._loggerModifications.exitScreenWithToPreviewButton();
            goToVehicleViewS();
            this.activateCoolDown();
         }
      }
      
      private function onRendererClickVehicleCompareHandler(param1:TechTreeEvent) : void
      {
         if(!this._requestInCoolDown && param1.index > -1)
         {
            compareVehicleS();
            this.activateCoolDown();
         }
      }
   }
}
