package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ImageRendererVO extends DAAPIDataClass
   {
       
      
      public var imgSrc:String = "";
      
      public var imgAlpha:Number = 1;
      
      public function ImageRendererVO(param1:Object = null)
      {
         super(param1);
      }
   }
}
