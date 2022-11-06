package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import scaleform.clik.data.DataProvider;
   
   public class TankCarouselFilterInitVO extends DAAPIDataClass
   {
      
      private static const PARAMS_FILTER:String = "mainBtn";
      
      private static const HOT_FILTERS:String = "hotFilters";
       
      
      public var isVisible:Boolean = true;
      
      public var isRanked:Boolean = false;
      
      public var isFrontline:Boolean = false;
      
      public var isComp7:Boolean = false;
      
      public var popoverAlias:String = "TankCarouselFilterPopover";
      
      private var _mainBtn:SimpleRendererVO = null;
      
      private var _hotFilters:DataProvider = null;
      
      public function TankCarouselFilterInitVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == PARAMS_FILTER)
         {
            this._mainBtn = new SimpleRendererVO(param2);
            return false;
         }
         if(param1 == HOT_FILTERS)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,"hotFilters must be Array");
            this._hotFilters = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this._hotFilters.push(new SimpleRendererVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:SimpleRendererVO = null;
         if(this._hotFilters)
         {
            for each(_loc1_ in this._hotFilters)
            {
               _loc1_.dispose();
            }
            this._hotFilters.cleanUp();
            this._hotFilters = null;
         }
         if(this._mainBtn)
         {
            this._mainBtn.dispose();
            this._mainBtn = null;
         }
         super.onDispose();
      }
      
      public function get mainBtn() : SimpleRendererVO
      {
         return this._mainBtn;
      }
      
      public function get hotFilters() : DataProvider
      {
         return this._hotFilters;
      }
   }
}
