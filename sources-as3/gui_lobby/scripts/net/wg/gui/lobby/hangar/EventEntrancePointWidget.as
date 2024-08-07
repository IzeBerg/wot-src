package net.wg.gui.lobby.hangar
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class EventEntrancePointWidget extends GFInjectComponent
   {
      
      private static const PADDING_X:int = 0;
      
      private static const PADDING_Y:int = 49;
      
      private static const PADDING_X_COMPACT:int = 5;
      
      private static const PADDING_Y_COMPACT:int = 40;
      
      private static const MARGIN_X:int = 12;
      
      private static const MARGIN_Y:int = 0;
      
      private static const MARGIN_X_COMPACT:int = 14;
      
      private static const MARGIN_Y_COMPACT:int = 12;
      
      private static const ENTRY_POINT_WIDTH:int = 280;
      
      private static const ENTRY_POINT_HEIGHT:int = 280;
      
      private static const ENTRY_POINT_WIDTH_COMPACT:int = 170;
      
      private static const ENTRY_POINT_HEIGHT_COMPACT:int = 150;
       
      
      private var _isCompact:Boolean = false;
      
      public function EventEntrancePointWidget()
      {
         super();
         setManageSize(true);
         setSize(ENTRY_POINT_WIDTH,ENTRY_POINT_HEIGHT);
      }
      
      public function get paddingX() : int
      {
         return !!this._isCompact ? int(PADDING_X_COMPACT) : int(PADDING_X);
      }
      
      public function get paddingY() : int
      {
         return !!this._isCompact ? int(PADDING_Y_COMPACT) : int(PADDING_Y);
      }
      
      public function get marginX() : int
      {
         return !!this._isCompact ? int(MARGIN_X_COMPACT) : int(MARGIN_X);
      }
      
      public function get marginY() : int
      {
         return !!this._isCompact ? int(MARGIN_Y_COMPACT) : int(MARGIN_Y);
      }
      
      public function set isCompact(param1:Boolean) : void
      {
         if(this._isCompact == param1)
         {
            return;
         }
         this._isCompact = param1;
         if(this._isCompact)
         {
            width = ENTRY_POINT_WIDTH_COMPACT;
            height = ENTRY_POINT_HEIGHT_COMPACT;
         }
         else
         {
            width = ENTRY_POINT_WIDTH;
            height = ENTRY_POINT_HEIGHT;
         }
         invalidateSize();
      }
   }
}
