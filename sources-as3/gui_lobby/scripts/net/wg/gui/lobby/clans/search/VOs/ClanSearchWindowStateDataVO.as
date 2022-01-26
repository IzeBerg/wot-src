package net.wg.gui.lobby.clans.search.VOs
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ClanSearchWindowStateDataVO extends DAAPIDataClass
   {
       
      
      public var foundClans:String = "";
      
      public var nextBtnEnabled:Boolean = false;
      
      public var previousBtnEnabled:Boolean = false;
      
      public var searchBtnEnabled:Boolean = false;
      
      public var searchInputEnabled:Boolean = false;
      
      public function ClanSearchWindowStateDataVO(param1:Object)
      {
         super(param1);
      }
   }
}
