package net.wg.gui.lobby.profile.pages.hof
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.CountersVo;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.browser.ServiceView;
   import net.wg.gui.lobby.profile.components.ProfileHofCenterGroup;
   import net.wg.gui.lobby.profile.components.ProfileHofFooter;
   import net.wg.gui.lobby.profile.components.ProfileHofStatusWaiting;
   import net.wg.infrastructure.base.meta.IProfileHofMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileHofMeta;
   import scaleform.clik.controls.Button;
   import scaleform.clik.events.ButtonEvent;
   
   public class ProfileHof extends ProfileHofMeta implements IProfileHofMeta
   {
      
      private static const ORIGINAL_BACKGROUND_ASPECT_RATIO:Number = 1.92;
      
      private static const PADDING_BOTTOM:int = 278;
      
      private static const PADDING_TOP:int = 170;
      
      private static const BETABTN_LEFT_PADDING:int = 8;
      
      private static const BETABTN_TOP_PADDING:int = 14;
      
      private static const INV_BACKGROUND_POSITION:String = "InvBackgroundPosition";
      
      private static const VEHICLES_RATING_BTN:String = "vehiclesBtn";
      
      private static const ACHIEVEMENTS_RATING_BTN:String = "achievementsBtn";
       
      
      public var footer:ProfileHofFooter = null;
      
      public var centerGroup:ProfileHofCenterGroup = null;
      
      public var betaBtn:Button = null;
      
      public var hofTitleTf:TextField = null;
      
      public var hofDescriptionTf:TextField = null;
      
      public var bgLoader:UILoaderAlt = null;
      
      public var serviceView:ServiceView = null;
      
      public var statusWaiting:ProfileHofStatusWaiting = null;
      
      public function ProfileHof()
      {
         super();
      }
      
      private static function onBetaBtnRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(PROFILE.SECTION_HOF_BETATOOLTIP);
      }
      
      private static function onBetaBtnRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function setBtnCounters(param1:Vector.<CountersVo>) : void
      {
         this.centerGroup.setBtnCounters(param1);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hofTitleTf.text = PROFILE.SECTION_HOF_MAINTITLE;
         this.hofDescriptionTf.text = PROFILE.SECTION_HOF_MAINDESCRIPTION;
         this.centerGroup.addEventListener(ButtonEvent.CLICK,this.onCenterGroupButtonClickHandler);
         this.footer.addEventListener(ButtonEvent.CLICK,this.onChangeStatusClickHandler);
         this.betaBtn.addEventListener(MouseEvent.ROLL_OVER,onBetaBtnRollOverHandler);
         this.betaBtn.addEventListener(MouseEvent.ROLL_OUT,onBetaBtnRollOutHandler);
         this.betaBtn.label = PROFILE.SECTION_HOF_BETABTN;
         this.betaBtn.buttonMode = false;
         this.bgLoader.addEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.autoSize = false;
         currentData = {};
         this.serviceView.visible = false;
         this.statusWaiting.visible = false;
         this.footer.visible = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         super.draw();
         if(isInvalid(INV_BACKGROUND_POSITION))
         {
            _loc1_ = App.appWidth;
            _loc2_ = App.appHeight - PADDING_TOP;
            _loc3_ = _loc1_ / _loc2_ > ORIGINAL_BACKGROUND_ASPECT_RATIO;
            this.updateBgLoaderSize(!!_loc3_ ? int(_loc1_) : int(_loc2_ * ORIGINAL_BACKGROUND_ASPECT_RATIO),!!_loc3_ ? int(_loc1_ / ORIGINAL_BACKGROUND_ASPECT_RATIO) : int(_loc2_));
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.visible = true;
      }
      
      override protected function applyResizing() : void
      {
         super.applyResizing();
         this.repositionLayout();
      }
      
      override protected function onDispose() : void
      {
         this.hofTitleTf = null;
         this.hofDescriptionTf = null;
         this.bgLoader.removeEventListener(UILoaderEvent.COMPLETE,this.onBgLoaderCompleteHandler);
         this.bgLoader.dispose();
         this.bgLoader = null;
         this.betaBtn.removeEventListener(MouseEvent.ROLL_OVER,onBetaBtnRollOverHandler);
         this.betaBtn.removeEventListener(MouseEvent.ROLL_OUT,onBetaBtnRollOutHandler);
         this.betaBtn.dispose();
         this.betaBtn = null;
         this.footer.removeEventListener(ButtonEvent.CLICK,this.onChangeStatusClickHandler);
         this.footer.dispose();
         this.footer = null;
         this.centerGroup.removeEventListener(ButtonEvent.CLICK,this.onCenterGroupButtonClickHandler);
         this.centerGroup.dispose();
         this.centerGroup = null;
         this.serviceView.dispose();
         this.serviceView = null;
         this.statusWaiting.dispose();
         this.statusWaiting = null;
         super.onDispose();
      }
      
      public function as_hideServiceView() : void
      {
         this.serviceView.visible = false;
         this.changeVisible(true);
      }
      
      public function as_hideWaiting() : void
      {
         this.statusWaiting.visible = false;
         this.footer.visible = true;
      }
      
      public function as_setBackground(param1:String) : void
      {
         this.bgLoader.source = param1;
      }
      
      public function as_setStatus(param1:String) : void
      {
         this.footer.setStatusData(param1);
      }
      
      public function as_showServiceView(param1:String, param2:String) : void
      {
         this.serviceView.setData(param1,param2);
         this.serviceView.y = (App.appHeight >> 1) - PADDING_TOP;
         this.serviceView.visible = true;
         this.changeVisible(false);
         this.statusWaiting.visible = false;
      }
      
      public function as_showWaiting(param1:String) : void
      {
         this.statusWaiting.visible = true;
         this.statusWaiting.setInfo(param1);
         this.footer.visible = false;
      }
      
      private function updateBgLoaderSize(param1:int, param2:int) : void
      {
         this.bgLoader.width = param1;
         this.bgLoader.height = param2;
         this.bgLoader.x = (App.appWidth - this.bgLoader.width >> 1) - this.x;
         this.bgLoader.y = 0;
      }
      
      private function repositionLayout() : void
      {
         var _loc1_:Number = App.appHeight;
         this.betaBtn.x = this.hofTitleTf.x + (this.hofTitleTf.width + this.hofTitleTf.textWidth >> 1) + BETABTN_LEFT_PADDING;
         this.betaBtn.y = this.hofTitleTf.y + BETABTN_TOP_PADDING;
         this.footer.y = _loc1_ - PADDING_BOTTOM;
         this.statusWaiting.y = _loc1_ - PADDING_BOTTOM;
         this.centerGroup.y = _loc1_ - this.centerGroup.height - PADDING_TOP >> 1;
         this.serviceView.y = (_loc1_ >> 1) - PADDING_TOP;
         invalidate(INV_BACKGROUND_POSITION);
      }
      
      private function changeVisible(param1:Boolean) : void
      {
         this.footer.visible = this.centerGroup.visible = this.bgLoader.visible = this.betaBtn.visible = this.hofTitleTf.visible = this.hofDescriptionTf.visible = param1;
      }
      
      private function onBgLoaderCompleteHandler(param1:Event) : void
      {
         invalidate(INV_BACKGROUND_POSITION);
      }
      
      private function onChangeStatusClickHandler(param1:ButtonEvent) : void
      {
         changeStatusS();
      }
      
      private function onCenterGroupButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:ISoundButtonEx = ISoundButtonEx(param1.target);
         switch(_loc2_.name)
         {
            case ACHIEVEMENTS_RATING_BTN:
               showAchievementsRatingS();
               break;
            case VEHICLES_RATING_BTN:
               showVehiclesRatingS();
         }
      }
   }
}
