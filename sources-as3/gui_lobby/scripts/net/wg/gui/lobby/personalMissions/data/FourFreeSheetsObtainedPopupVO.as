package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FourFreeSheetsObtainedPopupVO extends DAAPIDataClass
   {
      
      private static const ICON0:String = "icon0";
      
      private static const ICON1:String = "icon1";
      
      private static const ICON2:String = "icon2";
       
      
      public var description:String = "";
      
      public var header:String = "";
      
      private var _icon0:IconTextRendererVO;
      
      private var _icon1:IconTextRendererVO;
      
      private var _icon2:IconTextRendererVO;
      
      public function FourFreeSheetsObtainedPopupVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == ICON0)
         {
            this._icon0 = new IconTextRendererVO(param2);
            return false;
         }
         if(param1 == ICON1)
         {
            this._icon1 = new IconTextRendererVO(param2);
            return false;
         }
         if(param1 == ICON2)
         {
            this._icon2 = new IconTextRendererVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._icon0.dispose();
         this._icon0 = null;
         this._icon1.dispose();
         this._icon1 = null;
         this._icon2.dispose();
         this._icon2 = null;
         super.onDispose();
      }
      
      public function get icon0() : IconTextRendererVO
      {
         return this._icon0;
      }
      
      public function get icon1() : IconTextRendererVO
      {
         return this._icon1;
      }
      
      public function get icon2() : IconTextRendererVO
      {
         return this._icon2;
      }
   }
}
