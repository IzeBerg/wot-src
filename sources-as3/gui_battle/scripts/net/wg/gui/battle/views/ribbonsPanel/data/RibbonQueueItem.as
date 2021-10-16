package net.wg.gui.battle.views.ribbonsPanel.data
{
   public class RibbonQueueItem
   {
      
      public static const SHOW:String = "show";
      
      public static const HIDE:String = "hide";
       
      
      public var animationType:String = "";
      
      public var ribbonType:String = "";
      
      public var valueStr:String = "";
      
      public var vehName:String = "";
      
      public var vehType:String = "";
      
      public var countVehs:String = "";
      
      public var bonusLabel:String = "";
      
      public var ribbonId:Number = 0;
      
      public var isNew:Boolean = false;
      
      public var role:String = "";
      
      public function RibbonQueueItem()
      {
         super();
      }
      
      public function setData(param1:String, param2:String, param3:Number, param4:String, param5:String, param6:String, param7:String, param8:Boolean, param9:String, param10:String) : void
      {
         this.isNew = param8;
         this.ribbonId = param3;
         this.animationType = param1;
         this.ribbonType = param2;
         this.valueStr = param4;
         this.vehName = param5;
         this.vehType = param6;
         this.countVehs = param7;
         this.bonusLabel = param9;
         this.role = param10;
      }
   }
}
