package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ImageBlockVO extends DAAPIDataClass
   {
       
      
      public var imagePath:String = "";
      
      public var align:String = "left";
      
      public var width:Number = -1;
      
      public var height:Number = -1;
      
      public var alpha:Number = 1;
      
      public function ImageBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
