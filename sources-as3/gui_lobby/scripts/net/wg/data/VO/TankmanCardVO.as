package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TankmanCardVO extends DAAPIDataClass
   {
       
      
      public var name:String = "";
      
      public var nation:String = "";
      
      public var rank:String = "";
      
      public var vehicle:String = "";
      
      public var faceIcon:String = "";
      
      public var rankIcon:String = "";
      
      public var roleIcon:String = "";
      
      public function TankmanCardVO(param1:Object)
      {
         super(param1);
      }
   }
}
