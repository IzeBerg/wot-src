package net.wg.gui.intro
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class IntroInfoVO extends DAAPIDataClass
   {
       
      
      public var source:String = "";
      
      public var bufferTime:Number;
      
      public var volume:Number;
      
      public var canSkip:Boolean = false;
      
      public function IntroInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
