package net.wg.gui.bootcamp
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class BCOutroVideoVO extends DAAPIDataClass
   {
       
      
      public var source:String = "";
      
      public var volume:Number = -1;
      
      public var bufferTime:Number = -1;
      
      public var fitToScreen:Boolean = false;
      
      public function BCOutroVideoVO(param1:Object)
      {
         super(param1);
      }
   }
}
