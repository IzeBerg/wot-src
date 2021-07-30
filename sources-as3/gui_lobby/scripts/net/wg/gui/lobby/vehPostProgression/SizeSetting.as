package net.wg.gui.lobby.vehPostProgression
{
   public class SizeSetting
   {
       
      
      public var breakPointX:int = -1;
      
      public var breakPointY:int = -1;
      
      public var injectCmpWidth:int = -1;
      
      public var injectCmpHeight:int = -1;
      
      public var injectCmpTopOffset:int = -1;
      
      public var injectCmpXMargin:int = -1;
      
      public var bgScale:Number = -1;
      
      public var sizePrefix:String = "";
      
      public var vehicleTopOffset:int = -1;
      
      public var vehParamsTopOffset:int = -1;
      
      public function SizeSetting(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:Number, param8:String, param9:int, param10:int = 0)
      {
         super();
         this.breakPointX = param1;
         this.breakPointY = param2;
         this.injectCmpWidth = param3;
         this.injectCmpHeight = param4;
         this.injectCmpTopOffset = param5;
         this.injectCmpXMargin = param6;
         this.bgScale = param7;
         this.sizePrefix = param8;
         this.vehicleTopOffset = param9;
         this.vehParamsTopOffset = param10;
      }
   }
}
