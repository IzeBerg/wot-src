package net.wg.gui.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class WaitingPointcutItemVO extends DAAPIDataClass
   {
       
      
      public var value:int = -1;
      
      public var text:String = "";
      
      public function WaitingPointcutItemVO(param1:Object)
      {
         super(param1);
      }
   }
}
