package net.wg.gui.lobby.hangar.quests
{
   import net.wg.gui.components.containers.inject.GFInjectComponent;
   
   public class ArmoryYardEntryPoint extends GFInjectComponent implements IHeaderSecondaryEntryPoint
   {
      
      private static const WIDTH:int = 108;
      
      private static const HEIGHT:int = 108;
      
      private static const MARGIN:int = 2;
      
      private static const FLAG_WIDTH_WITHOUT_GLOW:int = 45;
      
      private static const GLOW_AREA_OFFSET:int = WIDTH - FLAG_WIDTH_WITHOUT_GLOW >> 1;
       
      
      private var _alias:String;
      
      public function ArmoryYardEntryPoint()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         setSize(WIDTH + MARGIN,HEIGHT + MARGIN);
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
      
      public function set alias(param1:String) : void
      {
         this._alias = param1;
      }
      
      public function get glowAreaOffset() : int
      {
         return GLOW_AREA_OFFSET;
      }
      
      override public function get x() : Number
      {
         return super.x + this.glowAreaOffset + MARGIN;
      }
   }
}
