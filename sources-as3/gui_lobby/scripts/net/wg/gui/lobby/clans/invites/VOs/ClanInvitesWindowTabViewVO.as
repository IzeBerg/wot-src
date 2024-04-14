package net.wg.gui.lobby.clans.invites.VOs
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ClanInvitesWindowTabViewVO extends ClanInvitesViewVO
   {
      
      private static const FILTERS:String = "filters";
       
      
      public var defaultFilter:String = "";
      
      private var _filters:Vector.<ClanInvitesWindowTableFilterVO> = null;
      
      public function ClanInvitesWindowTabViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._filters)
         {
            _loc1_.dispose();
         }
         this._filters.splice(0,this._filters.length);
         this._filters = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(FILTERS == param1)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,FILTERS + Errors.CANT_NULL);
            this._filters = new Vector.<ClanInvitesWindowTableFilterVO>();
            for each(_loc4_ in _loc3_)
            {
               this._filters.push(new ClanInvitesWindowTableFilterVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get filters() : Vector.<ClanInvitesWindowTableFilterVO>
      {
         return this._filters;
      }
   }
}
