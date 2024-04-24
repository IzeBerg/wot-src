package net.wg.gui.lobby.profile
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileMenuInfoVO extends DAAPIDataClass
   {
       
      
      public var sectionsData:Array;
      
      public var selectedAlias:String = "";
      
      public function ProfileMenuInfoVO(param1:Object)
      {
         super(param1);
      }
   }
}
