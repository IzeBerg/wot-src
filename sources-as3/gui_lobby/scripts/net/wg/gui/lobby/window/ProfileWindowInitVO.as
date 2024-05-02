package net.wg.gui.lobby.window
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileWindowInitVO extends DAAPIDataClass
   {
       
      
      public var fullName:String = "";
      
      public function ProfileWindowInitVO(param1:Object)
      {
         super(param1);
      }
   }
}
