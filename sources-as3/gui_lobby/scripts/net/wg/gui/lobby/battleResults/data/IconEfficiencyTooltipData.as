package net.wg.gui.lobby.battleResults.data
{
   public class IconEfficiencyTooltipData
   {
       
      
      public var type:String = null;
      
      public var disabled:Boolean = false;
      
      public var isGarage:Boolean = false;
      
      public var values:Array;
      
      public var discript:Array;
      
      public var value:String = null;
      
      public var critDamage:String = null;
      
      public var critWound:String = null;
      
      public var critDestruction:String = null;
      
      public var totalItemsCount:String = null;
      
      public var totalAssistedDamage:int = -1;
      
      public var killReason:int = -1;
      
      public var arenaType:int = -1;
      
      public function IconEfficiencyTooltipData()
      {
         this.values = [];
         this.discript = [];
         super();
      }
      
      public function setBaseValues(param1:Array, param2:Array, param3:int) : void
      {
         this.values = param1;
         this.discript = param2;
         this.totalItemsCount = String(param3);
      }
      
      public function setCritValues(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.critDamage = param1;
         this.critWound = param2;
         this.critDestruction = param3;
         this.totalItemsCount = param4;
      }
   }
}
