package net.wg.gui.lobby.profile.pages.formations.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FormationHeaderVO extends DAAPIDataClass
   {
       
      
      public var formationType:String = "";
      
      public var id:int = -1;
      
      public var title:String = "";
      
      public var joinDate:String = "";
      
      public var rank:String = "";
      
      public var showLink:Boolean = false;
      
      public function FormationHeaderVO(param1:Object)
      {
         super(param1);
      }
   }
}
