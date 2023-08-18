package net.wg.gui.lobby.messengerBar.carousel
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.components.controls.CloseButton;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   import scaleform.gfx.MouseEventEx;
   
   public class ChannelRenderer extends BaseChannelRenderer
   {
      
      private static const CLOSE_BTN_PADDING:uint = 23;
       
      
      public var closeButton:CloseButton = null;
      
      public function ChannelRenderer()
      {
         super();
         visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            openButton.width = _width;
            this.closeButton.x = _width - CLOSE_BTN_PADDING;
         }
         visible = getData() != null;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.closeButton.addEventListener(ButtonEvent.CLICK,onItemCloseClickHandler,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         this.closeButton.removeEventListener(ButtonEvent.CLICK,onItemCloseClickHandler);
         this.closeButton.dispose();
         this.closeButton = null;
         super.onDispose();
      }
      
      override protected function applyData() : void
      {
         var _loc1_:Boolean = false;
         super.applyData();
         openButton.iconSource = channelListData.icon;
         _loc1_ = channelListData.canClose;
         this.closeButton.visible = _loc1_;
         var _loc2_:Padding = DEFAULT_TF_PADDING;
         _loc2_.right = CLOSE_BTN_PADDING;
         openButton.textFieldPadding = _loc1_ || channelListData.isInProgress ? _loc2_ : DEFAULT_TF_PADDING;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         super.handleMouseRelease(param1);
         if(param1 is MouseEventEx && App.utils.commons.isRightButton(param1))
         {
            App.contextMenuMgr.show(!!channelListData.isPrivate ? CONTEXT_MENU_HANDLER_TYPE.APPEAL_CHANNEL_LIST : CONTEXT_MENU_HANDLER_TYPE.CHANNEL_LIST,this,channelListData);
         }
      }
   }
}
