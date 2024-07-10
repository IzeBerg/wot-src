package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.EventTournamentBannerInjectMeta;
   
   public class EventTournamentBannerInject extends EventTournamentBannerInjectMeta
   {
      
      private static const WIDTH_DEFAULT:int = 168;
      
      private static const HEIGHT_DEFAULT:int = 138;
      
      private static const WIDTH_EXTENDED:int = 265;
      
      private static const HEIGHT_EXTENDED:int = 250;
       
      
      private var _alias:String = "";
      
      private var _isExtended:Boolean = false;
      
      public function EventTournamentBannerInject(param1:String)
      {
         super();
         this._alias = param1;
         setManageSize(true);
         setSize(WIDTH_DEFAULT,HEIGHT_DEFAULT);
      }
      
      public function set isExtended(param1:Boolean) : void
      {
         if(param1 == this._isExtended)
         {
            return;
         }
         if(param1)
         {
            setSize(WIDTH_EXTENDED,HEIGHT_EXTENDED);
         }
         else
         {
            setSize(WIDTH_DEFAULT,HEIGHT_DEFAULT);
         }
         this._isExtended = param1;
         setIsExtendedS(this._isExtended);
      }
      
      public function get alias() : String
      {
         return this._alias;
      }
   }
}
