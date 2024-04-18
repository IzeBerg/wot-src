package net.wg.gui.lobby.messengerBar.carousel
{
   import net.wg.gui.components.advanced.BlinkingButton;
   import net.wg.gui.components.controls.ScrollBar;
   
   public class ChannelCarouselScrollBar extends ScrollBar
   {
       
      
      public function ChannelCarouselScrollBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function drawLayout() : void
      {
         constraints.update(_height,_width);
         downArrow.y = _width;
      }
      
      public function setUpArrowBlinking(param1:Boolean) : void
      {
         var _loc2_:BlinkingButton = BlinkingButton(upArrow);
         _loc2_.blinking = param1;
         _loc2_.tooltip = !!param1 ? TOOLTIPS.LOBY_MESSENGER_NEW_CHANNELS_CAROUSEL_BUTTON_LEFT : TOOLTIPS.LOBY_MESSENGER_CHANNELS_CAROUSEL_BUTTON_LEFT;
      }
      
      public function setDownArrowBlinking(param1:Boolean) : void
      {
         var _loc2_:BlinkingButton = BlinkingButton(downArrow);
         _loc2_.blinking = param1;
         _loc2_.tooltip = !!param1 ? TOOLTIPS.LOBY_MESSENGER_NEW_CHANNELS_CAROUSEL_BUTTON_RIGHT : TOOLTIPS.LOBY_MESSENGER_CHANNELS_CAROUSEL_BUTTON_RIGHT;
      }
   }
}
