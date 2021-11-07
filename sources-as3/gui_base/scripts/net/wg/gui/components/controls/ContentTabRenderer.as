package net.wg.gui.components.controls
{
   import net.wg.data.constants.Values;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ContentTabRenderer extends SoundButtonEx
   {
      
      private static const PREFIX_FIRST:String = "first_";
      
      private static const PREFIX_LAST:String = "last_";
      
      private static const PREFIX_SELECTED:String = "selected_";
       
      
      private var _isFirst:Boolean = false;
      
      private var _isLast:Boolean = false;
      
      public function ContentTabRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setState(_state);
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(StringUtils.isNotEmpty(_label) && textField != null)
         {
            textField.htmlText = _label;
         }
      }
      
      override protected function updateDisable() : void
      {
         if(disableMc != null)
         {
            disableMc.visible = !enabled;
            disableMc.x = bgMc.x;
            disableMc.y = bgMc.y;
            disableMc.scaleX = 1 / this.scaleX;
            disableMc.scaleY = 1 / this.scaleY;
            disableMc.widthFill = Math.round(bgMc.width * bgMc.scaleX * this.scaleX);
            disableMc.heightFill = Math.round(bgMc.height * bgMc.scaleY * this.scaleY);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         var _loc1_:String = Values.EMPTY_STR;
         if(this._isFirst)
         {
            _loc1_ += PREFIX_FIRST;
         }
         else if(this._isLast)
         {
            _loc1_ += PREFIX_LAST;
         }
         if(_selected)
         {
            _loc1_ += PREFIX_SELECTED;
         }
         return Vector.<String>([_loc1_]);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseEnabled = true;
      }
      
      public function get isFirst() : Boolean
      {
         return this._isFirst;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         this._isFirst = param1;
         invalidateState();
      }
      
      public function get isLast() : Boolean
      {
         return this._isLast;
      }
      
      public function set isLast(param1:Boolean) : void
      {
         this._isLast = param1;
         invalidateState();
      }
   }
}
