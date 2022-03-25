package net.wg.gui.battle.commander.views.spawnMenu
{
   import flash.geom.Rectangle;
   
   public class StageSizeSettings
   {
       
      
      public var spawnMenu:Rectangle;
      
      public var map:Rectangle;
      
      public var allyItem:Rectangle;
      
      public var enemyItem:Rectangle;
      
      public var supplyItem:Rectangle;
      
      public function StageSizeSettings(param1:Rectangle, param2:Rectangle, param3:Rectangle, param4:Rectangle, param5:Rectangle)
      {
         super();
         this.spawnMenu = param1;
         this.map = param2;
         this.allyItem = param3;
         this.enemyItem = param4;
         this.supplyItem = param5;
      }
   }
}
