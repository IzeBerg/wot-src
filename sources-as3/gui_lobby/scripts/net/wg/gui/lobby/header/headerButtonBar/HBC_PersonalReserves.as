package net.wg.gui.lobby.header.headerButtonBar
{
   import net.wg.gui.interfaces.IHeaderButtonResizableItem;
   import net.wg.gui.lobby.header.LobbyHeader;
   import net.wg.gui.lobby.header.events.PersonalReservesWidgetEvent;
   import scaleform.clik.utils.Padding;
   
   public class HBC_PersonalReserves extends HeaderButtonContentItem implements IHeaderButtonResizableItem
   {
      
      private static const MIN_WIDTH:Number = 58;
       
      
      public var personalReservesWidgetInject:HBC_PersonalReservesWidgetInject;
      
      public function HBC_PersonalReserves()
      {
         super();
         minScreenPadding = new Padding(0,1,0,2);
      }
      
      private function onInjectedResized(param1:PersonalReservesWidgetEvent) : void
      {
         this.updateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.personalReservesWidgetInject.addEventListener(PersonalReservesWidgetEvent.RESIZED,this.onInjectedResized);
      }
      
      override protected function onDispose() : void
      {
         this.personalReservesWidgetInject.removeEventListener(PersonalReservesWidgetEvent.RESIZED,this.onInjectedResized);
         super.onDispose();
      }
      
      public function getActualWidth() : Number
      {
         return bounds.width + this.leftPadding + this.rightPadding;
      }
      
      override protected function get leftPadding() : Number
      {
         var _loc1_:Number = 0;
         switch(screen)
         {
            case LobbyHeader.WIDE_SCREEN:
               _loc1_ = wideScreenPrc;
               break;
            case LobbyHeader.MAX_SCREEN:
               _loc1_ = maxScreenPrc;
         }
         return minScreenPadding.left + additionalScreenPadding.left * _loc1_ ^ 0;
      }
      
      override protected function get rightPadding() : Number
      {
         var _loc1_:Number = 0;
         switch(screen)
         {
            case LobbyHeader.WIDE_SCREEN:
               _loc1_ = wideScreenPrc;
               break;
            case LobbyHeader.MAX_SCREEN:
               _loc1_ = maxScreenPrc;
         }
         return minScreenPadding.right + additionalScreenPadding.right * _loc1_ ^ 0;
      }
      
      override protected function updateData() : void
      {
         if(this.personalReservesWidgetInject.isDisposed())
         {
            return;
         }
         var _loc1_:Number = this.personalReservesWidgetInject.targetWidth;
         if(availableWidth < _loc1_)
         {
            bounds.width = MIN_WIDTH;
            this.personalReservesWidgetInject.setSize(MIN_WIDTH,bounds.height);
         }
         else
         {
            bounds.width = _loc1_;
            this.personalReservesWidgetInject.setSize(_loc1_,bounds.height);
         }
         super.updateData();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
      }
      
      public function getMinAvailableWidth() : Number
      {
         return MIN_WIDTH;
      }
   }
}
