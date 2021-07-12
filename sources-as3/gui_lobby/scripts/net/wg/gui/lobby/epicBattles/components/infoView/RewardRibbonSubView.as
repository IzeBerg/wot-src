package net.wg.gui.lobby.epicBattles.components.infoView
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.epicBattles.components.AnimatedRewardRibbon;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesRewardRibbonVO;
   import net.wg.gui.lobby.epicBattles.events.RewardRibbonSubViewEvent;
   import net.wg.gui.lobby.epicBattles.utils.EpicHelper;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.events.ButtonEvent;
   
   public class RewardRibbonSubView extends UIComponentEx
   {
      
      private static const STANDARD_TOP_CONTINUE_BUTTON_RATIO:Number = 0.73;
      
      private static const STANDARD_TOP_RIBBON_RATIO:Number = 0.58;
       
      
      public var rewardTitle:TextField = null;
      
      public var rewardRibbon:AnimatedRewardRibbon = null;
      
      public var continueBTN:SoundButtonEx = null;
      
      public function RewardRibbonSubView()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.continueBTN.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this.continueBTN.dispose();
         this.continueBTN = null;
         this.rewardRibbon.dispose();
         this.rewardRibbon = null;
         this.rewardTitle = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.continueBTN.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
      }
      
      public function setData(param1:EpicBattlesRewardRibbonVO) : void
      {
         this.rewardTitle.htmlText = param1.rewardTitleHtmlText;
         this.continueBTN.label = param1.buttonText;
         this.rewardRibbon.setRibbonData(param1);
         this.rewardRibbon.visible = false;
         this.continueBTN.visible = false;
         this.rewardTitle.visible = false;
      }
      
      public function show() : void
      {
         this.rewardRibbon.visible = true;
         this.rewardRibbon.show();
         this.rewardTitle.visible = true;
         this.continueBTN.visible = true;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.rewardTitle.y = EpicHelper.calculateStaticMargin(param2) + EpicHelper.MAIN_MENU_BUTTON_BAR_HEIGHT;
         this.rewardTitle.x = param1 - this.rewardTitle.width >> 1;
         this.continueBTN.y = param2 * STANDARD_TOP_CONTINUE_BUTTON_RATIO;
         this.continueBTN.x = param1 - this.continueBTN.width >> 1;
         this.rewardRibbon.y = param2 * STANDARD_TOP_RIBBON_RATIO;
         this.rewardRibbon.x = param1 >> 1;
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new RewardRibbonSubViewEvent(RewardRibbonSubViewEvent.RIBBON_REWARD_BUTTON_CLICK));
      }
   }
}
