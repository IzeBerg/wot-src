package net.wg.gui.login.impl.components
{
   import net.wg.gui.components.controls.TileList;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class SocialIconsList extends TileList
   {
       
      
      public function SocialIconsList()
      {
         super();
      }
      
      override protected function calculateRendererTotal(param1:Number, param2:Number) : uint
      {
         _totalColumns = _dataProvider.length;
         _totalRows = 1;
         _totalRenderers = _totalRows * _totalColumns;
         return _totalRenderers;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         super.dataProvider = param1;
         invalidate(InvalidationType.RENDERERS,InvalidationType.SIZE);
      }
   }
}
