package net.wg.gui.lobby.profile.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ProfileGroupBlockVO extends DAAPIDataClass
   {
       
      
      public var id:int = -1;
      
      public var header:String = "";
      
      public var topLabel:String = "";
      
      public var topValue:String = "";
      
      public var bottomLabel:String = "";
      
      public var bottomValue:String = "";
      
      public var btnLabel:String = "";
      
      public var btnTooltip:String = "";
      
      public var btnEnabled:Boolean = false;
      
      public var btnVisible:Boolean = false;
      
      public function ProfileGroupBlockVO(param1:Object)
      {
         super(param1);
      }
   }
}
