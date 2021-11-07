package scaleform.clik.layout
{
   import flash.utils.Dictionary;
   
   public class LayoutData
   {
      
      public static const ASPECT_RATIO_4_3:String = "4:3";
      
      public static const ASPECT_RATIO_16_9:String = "16:9";
      
      public static const ASPECT_RATIO_16_10:String = "16:10";
       
      
      public var alignH:String = null;
      
      public var alignV:String = null;
      
      public var offsetH:int = -1;
      
      public var offsetV:int = -1;
      
      public var offsetHashH:Dictionary = null;
      
      public var offsetHashV:Dictionary = null;
      
      public var relativeToH:String = null;
      
      public var relativeToV:String = null;
      
      public var layoutIndex:int = -1;
      
      public var layoutIdentifier:String = null;
      
      public function LayoutData(param1:String = "none", param2:String = "none", param3:int = -1, param4:int = -1, param5:String = null, param6:String = null, param7:int = -1, param8:String = null)
      {
         super();
         this.alignH = param1;
         this.alignV = param2;
         this.offsetH = param3;
         this.offsetV = param4;
         this.relativeToH = param5;
         this.relativeToV = param6;
         this.layoutIndex = param7;
         this.layoutIdentifier = param8;
         this.offsetHashH = new Dictionary();
         this.offsetHashV = new Dictionary();
      }
      
      public function toString() : String
      {
         return "[LayoutData, h: " + this.alignH + ", v: " + this.alignV + ", oh: " + this.offsetH + ", ov: " + this.offsetV + ", relh: " + this.relativeToH + ", relv: " + this.relativeToV + ", idx: " + this.layoutIndex + "]";
      }
   }
}
