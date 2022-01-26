package net.wg.gui.lobby.clans.profile.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanProfileHeaderStateVO extends DAAPIDataClass
   {
       
      
      public var actionBtnLabel:String = "";
      
      public var actionBtnVisible:Boolean = false;
      
      public var actionBtnTooltip:String = "";
      
      public var topTF:String = "";
      
      public var topTFVisible:Boolean = false;
      
      public var iconBtnVisible:Boolean = false;
      
      public var iconBtnIcon:String = "";
      
      public var middleTF:String = "";
      
      public var middleTFVisible:Boolean = false;
      
      public var actionId:String = "";
      
      public function ClanProfileHeaderStateVO(param1:Object)
      {
         super(param1);
      }
   }
}
