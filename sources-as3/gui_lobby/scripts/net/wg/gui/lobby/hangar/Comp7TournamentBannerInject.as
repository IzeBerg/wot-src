package net.wg.gui.lobby.hangar
{
   import net.wg.infrastructure.base.meta.impl.Comp7TournamentBannerInjectMeta;
   
   public class Comp7TournamentBannerInject extends Comp7TournamentBannerInjectMeta
   {
      
      private static const WIDTH_DEFAULT:int = 168;
      
      private static const HEIGHT_DEFAULT:int = 138;
      
      private static const WIDTH_EXTENDED:int = 265;
      
      private static const HEIGHT_EXTENDED:int = 250;
       
      
      private var _isExtended:Boolean = false;
      
      public function Comp7TournamentBannerInject()
      {
         super();
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
   }
}
