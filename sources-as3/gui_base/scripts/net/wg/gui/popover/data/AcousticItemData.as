package net.wg.gui.popover.data
{
   public class AcousticItemData
   {
       
      
      public var id:String = "";
      
      public var label:String = "";
      
      public var img:String = "";
      
      public var isInteractive:Boolean = false;
      
      public var x:Number = -1;
      
      public var y:Number = -1;
      
      public var tooltip:String = "";
      
      public function AcousticItemData(param1:String, param2:String, param3:String, param4:String, param5:Boolean, param6:Number, param7:Number)
      {
         super();
         this.id = param1;
         this.label = param2;
         this.img = param3;
         this.isInteractive = param5;
         this.x = param6;
         this.y = param7;
         this.tooltip = param4;
      }
   }
}
