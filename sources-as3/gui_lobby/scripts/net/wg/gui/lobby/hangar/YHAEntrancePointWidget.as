package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.YHAEntrancePointWidgetMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class YHAEntrancePointWidget extends YHAEntrancePointWidgetMeta
   {
      
      private static const ENTRY_POINT_WIDTH:int = 262;
      
      private static const ENTRY_POINT_HEIGHT:int = 282;
      
      private static const ENTRY_POINT_SMALL_WIDTH:int = 182;
      
      private static const ENTRY_POINT_SMALL_HEIGHT:int = 202;
       
      
      private var _isSmall:Boolean = false;
      
      public function YHAEntrancePointWidget()
      {
         super();
         width = ENTRY_POINT_WIDTH;
         height = ENTRY_POINT_HEIGHT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._isSmall)
            {
               width = ENTRY_POINT_SMALL_WIDTH;
               height = ENTRY_POINT_SMALL_HEIGHT;
            }
            else
            {
               width = ENTRY_POINT_WIDTH;
               height = ENTRY_POINT_HEIGHT;
            }
         }
      }
      
      public function get isSmall() : Boolean
      {
         return this._isSmall;
      }
      
      public function set isSmall(param1:Boolean) : void
      {
         this._isSmall = param1;
         setIsSmallS(param1);
         invalidateSize();
      }
   }
}
