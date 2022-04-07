package net.wg.gui.lobby.profile.pages.awards.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ReceivedRareVO extends DAAPIDataClass
   {
       
      
      public var rareID:Number;
      
      public var rareIconId:String = "";
      
      public function ReceivedRareVO(param1:Object)
      {
         super(param1);
      }
   }
}
