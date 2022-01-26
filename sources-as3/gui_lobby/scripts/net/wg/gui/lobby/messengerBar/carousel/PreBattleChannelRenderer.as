package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.geom.ColorTransform;
   import net.wg.gui.components.advanced.IndicationOfStatus;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.messengerBar.carousel.data.MessengerBarConstants;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.utils.Padding;
   
   public class PreBattleChannelRenderer extends BaseChannelRenderer implements IUpdatable
   {
      
      private static const SPECIAL_PADDING_FOR_TEXT:Number = 27;
      
      private static const INDICATOR_PADDING:Number = 23;
       
      
      public var icon:UILoaderAlt = null;
      
      public var readyIndicator:IndicationOfStatus = null;
      
      private var _currentPadding:Padding = null;
      
      public function PreBattleChannelRenderer()
      {
         super();
         this._currentPadding = DEFAULT_TF_PADDING;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icon.mouseChildren = false;
         this.icon.mouseEnabled = false;
         this.readyIndicator.mouseChildren = false;
         this.readyIndicator.mouseEnabled = false;
         this.readyIndicator.visible = false;
         openButton.textFieldPadding = this._currentPadding;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.readyIndicator.dispose();
         this.readyIndicator = null;
         this._currentPadding = null;
         super.onDispose();
      }
      
      override protected function applyData() : void
      {
         super.applyData();
         if(channelListData.icon)
         {
            this.icon.source = channelListData.icon;
            this._currentPadding.left = SPECIAL_PADDING_FOR_TEXT;
         }
         else
         {
            this.icon.unload();
            this._currentPadding.left = DEFAULT_TF_PADDING.left;
         }
         var _loc1_:Boolean = channelListData.readyDataVO != null;
         if(_loc1_)
         {
            this.readyIndicator.visible = true;
            this.readyIndicator.status = !!channelListData.readyDataVO.isReady ? IndicationOfStatus.STATUS_READY : IndicationOfStatus.STATUS_NORMAL;
            openButton.showColorBg(false);
            openButton.setTextFieldColorTransform(new ColorTransform());
         }
         else
         {
            this.readyIndicator.visible = false;
            openButton.showColorBg(true);
            openButton.setTextFieldColorTransform(App.colorSchemeMgr.getTransform(MessengerBarConstants.MESSENGER_BAR_PRE_BATTLE_BTN_TEXT_COLOR));
         }
         this._currentPadding.right = channelListData.isInProgress || _loc1_ ? Number(INDICATOR_PADDING) : Number(DEFAULT_TF_PADDING.right);
         openButton.textFieldPadding = this._currentPadding;
      }
      
      public function update(param1:Object) : void
      {
         setData(param1);
      }
   }
}
