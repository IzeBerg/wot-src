package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionsTokenPopoverVO extends DAAPIDataClass
   {
       
      
      public var headerText:String = "";
      
      public var descrText:String = "";
      
      public var imageSrc:String = "";
      
      public var buyBtnLabel:String = "";
      
      public var buyBtnVisible:Boolean = false;
      
      public function MissionsTokenPopoverVO(param1:Object)
      {
         super(param1);
      }
   }
}
