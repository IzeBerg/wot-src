package net.wg.gui.lobby.epicBattles.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class EpicBattlesWelcomeBackViewVO extends DAAPIDataClass
   {
      
      private static const TILE_LIST:String = "tileList";
       
      
      public var bgSource:String = "";
      
      public var titleLabelBig:String = "";
      
      public var titleLabelSmall:String = "";
      
      public var playVideoBtnLabel:String = "";
      
      public var showBackBtn:Boolean = false;
      
      private var _tileListDP:DataProvider;
      
      public function EpicBattlesWelcomeBackViewVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == TILE_LIST && param2 != null)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,TILE_LIST + Errors.CANT_NULL);
            this._tileListDP = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._tileListDP.push(new InfoItemRendererVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._tileListDP != null)
         {
            for each(_loc1_ in this._tileListDP)
            {
               _loc1_.dispose();
            }
            this._tileListDP.cleanUp();
            this._tileListDP = null;
         }
         super.onDispose();
      }
      
      public function get tileListDP() : DataProvider
      {
         return this._tileListDP;
      }
   }
}
