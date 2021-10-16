package net.wg.gui.battle.views.damagePanel.components.tankman
{
   public class TankmanIdentifiers
   {
       
      
      public var normal:String;
      
      public var critical:String;
      
      public var adtXPadding:int = 0;
      
      public function TankmanIdentifiers(param1:String, param2:String, param3:int = 0)
      {
         super();
         this.normal = param1;
         this.critical = param2;
         this.adtXPadding = param3;
      }
   }
}
