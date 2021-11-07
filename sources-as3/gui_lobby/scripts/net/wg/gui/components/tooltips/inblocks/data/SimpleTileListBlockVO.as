package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class SimpleTileListBlockVO extends RendererDataVO
   {
      
      private static const VAL_LIST_ICON_SRC:String = "listIconSrc";
       
      
      public var columnWidth:int = 0;
      
      public var rowHeight:int = 0;
      
      public var horizontalGap:int = 0;
      
      public var verticalGap:int = 0;
      
      public var align:String = "left";
      
      public var renderersAlign:String = "renderers_left";
      
      private var _iconSrcDP:DataProvider = null;
      
      public function SimpleTileListBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         if(param1 == VAL_LIST_ICON_SRC)
         {
            this._iconSrcDP = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            for each(_loc4_ in _loc3_)
            {
               this._iconSrcDP.push(new dataType(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._iconSrcDP)
         {
            if(_loc1_ is IDisposable)
            {
               IDisposable(_loc1_).dispose();
            }
         }
         this._iconSrcDP.cleanUp();
         this._iconSrcDP = null;
         super.onDispose();
      }
      
      public function get iconSrcDP() : DataProvider
      {
         return this._iconSrcDP;
      }
   }
}
